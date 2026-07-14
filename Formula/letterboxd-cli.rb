# Homebrew formula template — el workflow de release sustituye los
# placeholders `0.1.0` y `2a2befb426a7eef398e76b2c641f66ddeeb51f653e02033760f052b2564edc1a` con los valores reales
# de cada release y hace push del resultado al repo `ser356/homebrew-tap`
# (fichero `Formula/letterboxd-cli.rb`).
#
# Solo macOS Apple Silicon. Para Linux se recomienda `cargo install --git`
# o el flake.nix del repo.
class LetterboxdCli < Formula
  desc "Letterboxd recs + torrent search + BitTorrent streaming"
  homepage "https://github.com/ser356/letterboxd-cli"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/ser356/letterboxd-cli/releases/download/v#{version}/letterboxd-cli-macos-arm64.tar.gz"
      sha256 "2a2befb426a7eef398e76b2c641f66ddeeb51f653e02033760f052b2564edc1a"
    end
  end

  def install
    bin.install "letterboxd-cli"
  end

  def caveats
    <<~EOS
      La primera vez que abras la TUI, se te pedirá login de Letterboxd.
      Las credenciales de la app ya vienen bakeadas — no tienes que
      configurar nada más.

      Para el streaming BitTorrent hace falta VLC:
        brew install --cask vlc
    EOS
  end

  test do
    assert_match "letterboxd-cli", shell_output("#{bin}/letterboxd-cli --help 2>&1", 2)
  end
end
