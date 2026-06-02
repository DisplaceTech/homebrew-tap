class Journal < Formula
  desc "Local-first developer journal with semantic search and AI synthesis"
  homepage "https://displace.tech"
  version "1.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/ericmann/journal/releases/download/v#{version}/journal_v#{version}_darwin_arm64"
      sha256 "bcaf0bfb09a052cace85e40f907491df7276bcd5621ba46e5198b56a302a644d"
    end
    on_intel do
      url "https://github.com/ericmann/journal/releases/download/v#{version}/journal_v#{version}_darwin_amd64"
      sha256 "5b68ec10c984740980a1f68106318d9ae0cd2b4fe57d99547825ecb19ed5993a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ericmann/journal/releases/download/v#{version}/journal_v#{version}_linux_arm64"
      sha256 "2b3f99d533472c93f725543c0d0f0209d45cd482689cf466fe65fc30d1e2033e"
    end
    on_intel do
      url "https://github.com/ericmann/journal/releases/download/v#{version}/journal_v#{version}_linux_amd64"
      sha256 "1d90158044183a33c3c7a0bf7ae0eab367046f3b9d16bfd3c63ef61296953155"
    end
  end

  livecheck do
    skip "Updated on each release."
  end

  # Releases ship a single bare binary per platform; install whichever was
  # downloaded as `journal`.
  def install
    bin.install Dir["journal_*"].first => "journal"
  end

  def caveats
    <<~EOS
      journal needs a local Ollama for indexing and search:
        1. install Ollama:        https://ollama.com
        2. pull the embed model:  ollama pull qwen3-embedding:4b
        3. verify your setup:     journal doctor

      An ANTHROPIC_API_KEY in your environment is only needed for `journal synth`.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/journal --version")
  end
end
