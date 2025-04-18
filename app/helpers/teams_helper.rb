module TeamsHelper
  def team_logo(team)
    team.logo.attached? ? team.logo : "default-logo.png"
  end
end
