class Smartling < Formula
  desc "CLI to upload and download translations"
  homepage "https://github.com/Fitbit/smartling"
  url "https://github.com/Fitbit/smartling/archive/v0.5.0.tar.gz"
  sha256 "54d6039af86a9a2651bf7b193097584f68c9dd93b26184caf9da014bc899e562"
  head "https://github.com/Fitbit/smartling.git"
  depends_on "go"
  depends_on "glide"
  def install
    ENV["GOPATH"] = buildpath
    glidepath = buildpath/".glide"
    smartlingpath = buildpath/"src/github.com/Fitbit/smartling"
    smartlingpath.install buildpath.children
    cd smartlingpath do
      system "glide", "--home", "#{glidepath}", "install", "--skip-test"
      system "go", "build", "-ldflags", "-X main.Version=#{version}", "-o", "smartling", "./cli/..."
      bin.install "smartling"
      prefix.install_metafiles
    end
  end
  test do
    version = pipe_output("#{bin}/smartling --version")
    assert_match version.to_s, version
  end
end
