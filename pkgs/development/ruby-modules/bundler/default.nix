{ buildRubyGem, ruby }:

buildRubyGem rec {
  inherit ruby;
  name = "${gemName}-${version}";
  gemName = "bundler";
  version = "2.0.2";
  source.sha256 = "0zdh2cqsnvlyzwx22dbizfjal1b98ibcx7jxm5c2j2ydq68shqni";
  dontPatchShebangs = true;

  postFixup = ''
    sed -i -e "s/activate_bin_path/bin_path/g" $out/bin/bundle
  '';
}
