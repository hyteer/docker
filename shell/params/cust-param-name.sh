#!/bin/sh
#说明
show_usage="args: [-l , -r , -b , -w]\
                                  [--local-repository=, --repository-url=, --backup-dir=, --webdir=]"
#参数
# 本地仓库目录
opt_localrepo=""

# git仓库url
opt_url=""

# 备份目录
opt_backupdir=""

# web目录
opt_webdir=""

GETOPT_ARGS=`getopt -o l:r:b:w: -al local-repository:,repository-url:,backup-dir:,webdir: -- "$@"`
eval set -- "$GETOPT_ARGS"
#获取参数
while [ -n "$1" ]
do
        case "$1" in
                -l|--local-repository) opt_localrepo=$2; shift 2;;
                -r|--repository-url) opt_url=$2; shift 2;;
                -b|--backup-dir) opt_backupdir=$2; shift 2;;
                -w|--webdir) opt_webdir=$2; shift 2;;
                --) break ;;
                *) echo $1,$2,$show_usage; break ;;
        esac
done

if [[ -z $opt_localrepo || -z $opt_url || -z $opt_backupdir || -z $opt_webdir ]]; then
        echo $show_usage
        echo "opt_localrepo: $opt_localrepo , opt_url: $opt_url , opt_backupdir: $opt_backupdir , opt_webdir: $opt_webdir"
        exit 0
fi
