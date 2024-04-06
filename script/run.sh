echo "Run chromedriver"
npm install chromedriver --chromedriver_version=LATEST
echo "Run Edgebrowser"
npm install edgedriver
echo "----------------------------------------------"
npx wdio run ./wdio.conf.ts