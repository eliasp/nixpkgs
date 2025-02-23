{ ... }:
{
  name = "systemd-localectl";

  nodes.machine = { pkgs, ... }:
  {
    i18n = {
      defaultLocale = "en_US.UTF-8";
      supportedLocales = [
        "C.UTF-8/UTF-8"
        "en_US.UTF-8/UTF-8"
        "de_DE.UTF-8/UTF-8"
      ];
    };
  };

  testScript = ''
    machine.wait_for_unit("multi-user.target")

    with subtest("localectl returns the default locale as supported"):
      localectl_list = machine.succeed("localectl list-locales")
      print(localectl_list)
      assert "en_US.UTF-8" in localectl_list
  '';
}
