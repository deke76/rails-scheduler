class AddressesController < ApplicationController
  before_action :set_address, only: %i[ show edit update destroy ]
  require 'net/http'
  require 'json'
  require 'cgi'
  require 'open-uri'

  # GET /addresses or /addresses.json
  def index
    @addresses = Address.all
  end

  # GET /addresses/1 or /addresses/1.json
  def show
  end

  # GET /addresses/new
  def new
    @address = Address.new
    respond_to do |format|
      format.html
      format.turbo_stream { 
        render turbo_stream: turbo_stream.replace("new_address", 
          partial: "addresses/form", 
          locals: { address: @address, show_back: false }) 
      }
    end
  end

  # GET /addresses/1/edit
  def edit
  end

  # POST /addresses or /addresses.json
  def create
    @address = Address.new(address_params)

    respond_to do |format|
      if @address.save
        attach_map_image(@address)
        format.turbo_stream { 
          render turbo_stream: [
            turbo_stream.replace("new_address", ""),
            turbo_stream.update("ice_time_address_id", 
              partial: "addresses/select", 
              locals: { addresses: Address.all, ice_time: @ice_time })
          ]
        }
        format.html { redirect_to address_url(@address), notice: "Address was successfully created." }
        format.json { render :show, status: :created, location: @address }
      else
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace("new_address", 
            partial: "addresses/form", 
            locals: { address: @address, show_back: false })
        }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addresses/1 or /addresses/1.json
  def update
    respond_to do |format|
      if @address.update(address_params)
        attach_map_image(@address)
        format.html { redirect_to address_url(@address), notice: "Address was successfully updated." }
        format.json { render :show, status: :ok, location: @address }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1 or /addresses/1.json
  def destroy
    @address.destroy!

    respond_to do |format|
      format.html { redirect_to addresses_url, notice: "Address was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def autocomplete
    query = params[:query]
    return render turbo_stream: turbo_stream.update("address_autocomplete_results", partial: "autocomplete_results", locals: { addresses: [] }) unless query.length >= 3
    
    @addresses = osm_search(query)

    respond_to do |format|
      format.turbo_stream { 
        render turbo_stream: turbo_stream.update("address_autocomplete_results", 
               partial: "autocomplete_results", 
               locals: { addresses: @addresses })
      }
      format.html { render partial: "autocomplete_results", locals: { addresses: @addresses } }
      format.json { render json: @addresses }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def address_params
      params.fetch(:address, {}).permit(
        :name,
        :unit_number,
        :street_number,
        :street,
        :city,
        :country_name,
        :province,
        :postal_code,
      )
    end

    def osm_search(query)
      url = URI("https://nominatim.openstreetmap.org/search?q=#{CGI.escape(query)}&format=json&addressdetails=1&limit=5")
      response = Net::HTTP.get(url)
      JSON.parse(response)
    end

    def google_places_search(query)
      # Note: You'll need to set up your Google Places API key in credentials
      api_key = Rails.application.credentials.google_places_api_key
      
      url = URI("https://places.googleapis.com/v1/places:searchText")
      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true
      
      request = Net::HTTP::Post.new(url)
      request["Content-Type"] = "application/json"
      request["X-Goog-Api-Key"] = api_key
      request["X-Goog-FieldMask"] = "places.displayName,places.formattedAddress,places.location"
      
      request.body = JSON.dump({
        "textQuery": query,
        "maxResultCount": 5
      })
      
      response = https.request(request)
      JSON.parse(response.body)
    rescue StandardError => e
      Rails.logger.error "Google Places API error: #{e.message}"
      []
    end

    def attach_map_image(address)
      return unless address.latitude && address.longitude

      # Remove any existing map image
      address.map_image.purge if address.map_image.attached?

      # Generate the static map URL
      map_url = "https://static-maps.yandex.ru/1.x/?" + {
        ll: "#{address.longitude},#{address.latitude}",
        size: "450,450",
        z: "15",
        l: "map"
      }.to_query

      # Download and attach the map image
      begin
        downloaded_image = URI.open(map_url)
        address.map_image.attach(
          io: downloaded_image,
          filename: "map_#{address.id}.png",
          content_type: "image/png"
        )
      rescue OpenURI::HTTPError => e
        Rails.logger.error "Failed to download map image: #{e.message}"
      end
    end
end
