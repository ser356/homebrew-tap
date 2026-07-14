# Homebrew formula template — el workflow de release sustituye
# `0.1.0` y `da1ac3db5fd7aec01fd38920219f4ccd987dcdddbef94050222675a5f1862e4e` con los valores reales de cada
# release y hace push del resultado al repo `ser356/homebrew-tap`
# (fichero `Formula/letterboxd-cli.rb`).
#
# Instalación desde código fuente: brew descarga el tarball del tag,
# compila con cargo y coloca el binario en `bin`. Las credenciales de app
# están hardcoded en el source, así que el binario resultante ya funciona
# sin configuración adicional.
class LetterboxdCli < Formula
  desc "Letterboxd recs + torrent search + BitTorrent streaming"
  homepage "https://github.com/ser356/letterboxd-cli"
  url "https://github.com/ser356/letterboxd-cli/archive/refs/tags/v0.1.0.tar.gz"
  version "0.1.0"
  sha256 "da1ac3db5fd7aec01fd38920219f4ccd987dcdddbef94050222675a5f1862e4e"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: ".")
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
