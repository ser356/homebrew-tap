# Homebrew formula template — el workflow `publish-packages.yml` sustituye
# los placeholders `0.1.0`, `cdc11ee0e69fde8ebc6519b3d81b82ac23c2454b5aa12139d623d5faee6f0223` y `2b1d6de0dba85ff55da9756d6779dd015fd65582db6f0649871e25383a990b9e`
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
      sha256 "cdc11ee0e69fde8ebc6519b3d81b82ac23c2454b5aa12139d623d5faee6f0223"
    end
    # Nota: no publicamos binario x86_64-apple-darwin porque los runners
    # macos-13 de GitHub Actions están deprecated. Los Macs Intel deben
    # instalar vía `cargo install --git https://github.com/ser356/letterboxd-cli`.
  end

  on_linux do
    on_intel do
      url "https://github.com/ser356/letterboxd-cli/releases/download/v#{version}/letterboxd-cli-linux-x86_64.tar.gz"
      sha256 "2b1d6de0dba85ff55da9756d6779dd015fd65582db6f0649871e25383a990b9e"
    end
  end

  # VLC es requerido para la funcionalidad de streaming BitTorrent (`s`
  # en la TUI). En macOS se instala como cask; en Linux como formula
  # normal.
  on_macos do
    depends_on cask: "vlc"
  end
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
      configurar nada más. VLC se instaló automáticamente como
      dependencia para el streaming.
    EOS
  end

  test do
    assert_match "letterboxd-cli", shell_output("#{bin}/letterboxd-cli --help 2>&1", 2)
  end
end
