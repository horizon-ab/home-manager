{ wallpapers, ... }:
{
  stylix.enable = true;

  stylix.image = "${wallpapers}/sus.png";
  stylix.polarity = "dark";

  stylix.targets = {
    waybar.enable = false;
    hyprland.enable = false;
    kde.enable = false;
  };
}
