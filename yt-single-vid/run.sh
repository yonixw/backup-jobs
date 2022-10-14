BEST_RES=${BEST_RES:-720}
URL="https://www.youtube.com/playlist?list=$PLID"

# Download the best video available but no better than $BEST_RES,
# or the worst video if there is no video under $BEST_RES

FILTER_CONFIG="
    --match-filters \"!is_live\"
    -f \"bv*[height<=$BEST_RES]+ba/b[height<=$BEST_RES] / wv*+ba/w\" 
    "

# linear=1::2 ==> 1 + 2x, where x=0...[--retries]
NETOWRK_CONFIG="
    --socket-timeout 30 
    --max-filesize 5G 
    --limit-rate 2M 
    --retries 10 
    --retry-sleep linear=1::2 
    --no-check-certificates 
    "

STATE_CONFIG="
    --download-archive YT_PL.STATE 
    "

# Output types:
# subtitle, thumbnail, description, infojson, link, chapter
# pl_thumbnail, pl_description, pl_infojson,
# pl_video (if video merging the playlist)

# --write-comments 
#     -o \"pl_thumbnail:./playlist-%(playlist_id)s/%(playlist_title)s.%(ext)s\" 
#    -o \"pl_description:./playlist-%(playlist_id)s/%(playlist_title)s.%(ext)s\"  
#     -o \"./playlist-%(playlist_id)s/video-%(id)s/%(title)s.%(ext)s\" 
#    -o \"pl_infojson:./playlist-%(playlist_id)s/infojson.%(ext)s\" 
SAVE_CONFIG="
    --windows-filenames 
    --trim-filenames 100 
    --write-info-json 
    --write-thumbnail 
    --write-subs 
    --write-auto-subs 
    -o \"$PLID/%(id)s/%(title)s.%(ext)s\"
    "

# --skip-download 
SKIP_CONFIG=" 
     
     "

EXE_CONFIG="
    --ffmpeg-location $(pwd)
    "


ALL_CONFIGS="$FILTER_CONFIG $NETOWRK_CONFIG 
    $STATE_CONFIG $SAVE_CONFIG 
    $SKIP_CONFIG $EXE_CONFIG 
    $URL"


#echo $(echo "$ALL_CONFIGS"|tr -d '\n')

echo $(echo "$ALL_CONFIGS"|tr -d '\n') | xargs ./yt-dlp_linux 

echo $? > yt-dlp_std_output.txt