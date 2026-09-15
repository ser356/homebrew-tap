class Tetsuoc < Formula
  desc "Self-hosted systems language and compiler"
  homepage "https://github.com/ser356/tetsuo"
  url "https://github.com/ser356/tetsuo/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "e0eef621ba0cad23ea665c9116c1f878079c1121f1979d3d91334bc938b75223"

  depends_on macos: :big_sur
  depends_on arch: :arm64

  def install
    bin.install "bootstrap/tetsuoc.macho" => "tetsuoc"
  end

  test do
    (testpath/"main.tt").write "fun main() -> u64 { return 0 }\n"
    system bin/"tetsuoc", "--emit=macho", "main.tt", "-o", "main"
    assert_path_exists testpath/"main"
    chmod 0755, testpath/"main"
    system testpath/"main"
  end
end