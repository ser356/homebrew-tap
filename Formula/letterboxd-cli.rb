# Homebrew formula template — el workflow `publish-packages.yml` sustituye
# los placeholders `0.1.0`, `bb524d97a3d4926ec52e7cf67a47c5ced86b5df69420a61a96ac403c50d3ca77` y `e440721b75f5899cb76384e9f4a506e623dd0bfb3de66f143f38b8ec100d6ee1`
# con los valores reales de cada release, y hace push del resultado al repo
# `ser356/homebrew-tap` (fichero `Formula/letterboxd-cli.rb`).
class LetterboxdCli < Formula
  desc "Letterboxd recs + torrent search + BitTorrent streaming"
  homepage "https://github.com/ser356/letterboxd-cli"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/ser356/letterboxd-cli/releases/download/v#{version}/letterboxd-cli-macos-arm64.tar.gz"
      sha256 "bb524d97a3d4926ec52e7cf67a47c5ced86b5df69420a61a96ac403c50d3ca77"
    end
    # Nota: no publicamos binario x86_64-apple-darwin porque los runners
    # macos-13 de GitHub Actions están deprecated. Los Macs Intel deben
    # instalar vía `cargo install --git https://github.com/ser356/letterboxd-cli`.
  end

  on_linux do
    on_intel do
      url "https://github.com/ser356/letterboxd-cli/releases/download/v#{version}/letterboxd-cli-linux-x86_64.tar.gz"
      sha256 "e440721b75f5899cb76384e9f4a506e623dd0bfb3de66f143f38b8ec100d6ee1"
    end
  end

  # VLC en Linux existe como fórmula normal y se puede declarar dep dura.
  # En macOS VLC solo está disponible como cask (GUI app), y Homebrew ya
  # no permite que una fórmula dependa de un cask. Se documenta en caveats
  # como paso manual.
  on_linux do
    depends_on "vlc"
  end

  def install
    bin.install "letterboxd-cli"
  end

  def caveats
    <<~EOS
      La primera vez que abras la TUI, se te pedirá login de Letterboxd.
      Las credenciales de la app ya vienen bakeadas — no tienes que
      configurar nada más.

      Para el streaming BitTorrent hace falta VLC. En macOS instálalo
      con:
        brew install --cask vlc
    EOS
  end

  test do
    assert_match "letterboxd-cli", shell_output("#{bin}/letterboxd-cli --help 2>&1", 2)
  end
end
