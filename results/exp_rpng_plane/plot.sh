
# Source our workspace directory to load ENV variables
source /home/patrick/workspace/catkin_ws_plane/devel/setup.bash


# get directory
BASEDIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo "$BASEDIR"


# do not display figures
export MPLBACKEND=Agg

rosrun ov_eval error_comparison posyaw "$BASEDIR/truths/" "$BASEDIR/algorithms/" > "$BASEDIR/output_traj.txt"
#rosrun  --prefix 'gdb -ex run --args' ov_eval error_comparison posyaw truths/ algorithms/



echo "\n\n========================================="
echo "timing_comparison table_01.txt"
echo "========================================="
dataset="table_01"
cmd_files=""
export_folder="$BASEDIR/timings_edited/"
mkdir -p $export_folder
for d in $BASEDIR/timings/* ; do
    files=("$d/$dataset/"*)
    echo $d
    first_run=${files[0]}
    filename=$(basename -- "$d")
    filename="$(echo "$filename" | sed "s/ //g")" # no space support...
    new_run="$export_folder/$filename.txt"
    cp -- "$first_run" "$new_run"
    cmd_files="$new_run $cmd_files"
done
rosrun ov_eval timing_comparison $cmd_files > "$BASEDIR/output_timing.txt"
rm -rf $export_folder



