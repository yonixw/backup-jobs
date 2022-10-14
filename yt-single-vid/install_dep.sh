
echo "yt-dlp: Downloading latest version..."
curl -s https://api.github.com/repos/yt-dlp/yt-dlp/releases/latest \
| grep url |  grep yt-dlp_linux | grep -v .zip \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qiO -


echo "ffmpeg: Downloading latest version..."
curl -s https://api.github.com/repos/yt-dlp/FFmpeg-Builds/releases/latest \
| grep url |  grep ffmpeg-master-latest-linux64-gpl.tar.xz \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qiO -

echo "ffmpeg: export"
tar -xf ffmpeg-master-latest-linux64-gpl.tar.xz
cp ffmpeg-master-latest-linux64-gpl/bin/ffmpeg ./ffmpeg

echo "Making execute"
chmod +x yt-dlp_linux
chmod +x ffmpeg

echo "Printing Version:"
./yt-dlp_linux --version
./ffmpeg -version
