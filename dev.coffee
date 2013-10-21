
bash = require "calabash"

bash.do "compile and watch",
  "pkill -f doodle"
  "coffee -o src/ -wcm coffee/"
  "doodle index.html src/ cirru/"