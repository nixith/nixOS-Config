{ pkgs, ... }:
{
  programs.eclipse =
    let
      eclipsePlugins = pkgs.eclipses.plugins;
    in
    {
      enable = true;
      package = pkgs.eclipses.eclipse-java;
      plugins = [
        # on the off chance that older versions are causing problems, i am going to manually build everything.
        #eclipsePlugins.color-theme #figure out catppuccin
        (eclipsePlugins.buildEclipsePlugin rec {
          name = "color-theme-${version}";
          version = "1.0.0.201410260308"; # TODO: update

          srcFeature = pkgs.fetchurl {
            url = "https://eclipse-color-theme.github.io/update/features/com.github.eclipsecolortheme.feature_${version}.jar";
            sha256 = "128b9b1cib5ff0w1114ns5mrbrhj2kcm358l4dpnma1s8gklm8g2";
          };

          srcPlugin = pkgs.fetchurl {
            url = "https://eclipse-color-theme.github.io/update/plugins/com.github.eclipsecolortheme_${version}.jar";
            sha256 = "0wz61909bhqwzpqwll27ia0cn3anyp81haqx3rj1iq42cbl42h0y";
          };
        })
        # Required for CSC 216
        #eclipsePlugins.checkstyle # figure out how to bundle csc checkstyle. Preferably declaratively
        # (eclipsePlugins.buildEclipseUpdateSite rec { # NOTE: checkstyle moved websites, I need to figure out how to manage their new update site
        #   name = "checkstyle-${version}";
        #   version = "10.12.2.202401231459";
        #
        #   src = pkgs.fetchzip {
        #     stripRoot = false;
        #     url = "https://checkstyle.org/eclipse-cs-update-site/releases/${version}.zip";
        #     sha256 = "07fymk705x4mwq7vh2i6frsf67jql4bzrkdzhb4n74zb0g1dib60";
        #   };
        # })
        # eclipsePlugins.eclemma # included by default
        #eclipsePlugins.spotbugs # version is too old for my use case, instead build myself

        (eclipsePlugins.buildEclipseUpdateSite rec {
          name = "spotbugs-${version}";
          version = "4.8.3";

          src = pkgs.fetchzip {
            stripRoot = false;
            url = "https://github.com/spotbugs/spotbugs/releases/download/${version}/eclipsePlugin.zip";
            sha256 = "sha256-n2Koq5Cnl4z7jJMP8Dvrh8jPhvqINMAI9ML57If0JIs=";
          };
        })
        # nixpkgs does not have pmd
        (eclipsePlugins.buildEclipseUpdateSite rec {
          name = "pmd-${version}";
          version = "7.0.0.v20230930-1814-rc4";
          src = pkgs.fetchzip {
            stripRoot = false;
            url = "https://github.com/pmd/pmd-eclipse-plugin/releases/download/${version}/net.sourceforge.pmd.eclipse.p2updatesite-${version}.zip";
            sha256 = "sha256-LZ1IMbDQndCg1Svfcw0cUWaTvRZH+s8sNTF2W8y1c78=";
          };
        })
        eclipsePlugins.vrapper
      ];
    };
}
