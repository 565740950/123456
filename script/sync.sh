#!/bin/bash
# sync.sh
cd ..
git add .
git commit -m "Commit at `date`"
git pull  --allow origin hexo
git push origin hexo
