class Smartling < Formula
  desc "CLI to upload and download translations"
  homepage "https://github.com/fitbit/smartling"
  url "https://github.com/Fitbit/smartling/archive/v0.4.4.tar.gz"
  sha256 "f49340e807561fabc153a156a3e059717941b46e0c4c364273831c0804e28e43"

  head "https://github.com/fitbit/smartling.git"

  depends_on "go"
  depends_on "glide"

  def install
    ENV["GOPATH"] = buildpath
    glidepath = buildpath/".glide"
    smartlingpath = buildpath/"src/github.com/fitbit/smartling"
    smartlingpath.install buildpath.children

    cd smartlingpath do
      system "glide", "--home", "#{glidepath}", "install", "--skip-test"
      system "go", "build", "-o", "smartling", "./cli/..."
      bin.install "smartling"
      prefix.install_metafiles
    end
  end

  test do
    version = pipe_output("#{bin}/smartling --version")
    assert_match version.to_s, version
  end
end
