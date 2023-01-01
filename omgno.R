# David Lawrence Miller 2021

setwd("~/lexknowssystems")

make_im <- system2("./lex.sh")

post_it <- function(fn="merged_final.png"){
  # switch account
  fuzzy_dog0 <- system2("/usr/local/bin/twurl", "set default LexKnowsSystems")
  # how to from here:
  # https://github.com/twitter/twurl/issues/58
  fuzzy_dog <- system2("/usr/local/bin/twurl",
                  paste0("-H upload.twitter.com \"/1.1/media/upload.json\" -f ",
                         fn,
                         " -F media -X POST"), stdout=TRUE)

  fuzzy_dog <- sub(".*\"media_id\":(\\d+).*", "\\1", fuzzy_dog)
  cat(fuzzy_dog,"\n")
  fuzzy_dog2 <- system2("/usr/local/bin/twurl",
                        paste0("\"/1.1/statuses/update.json\" -d \"media_ids=",
                               fuzzy_dog,
                               "&status=\""))

  # reset default
  fuzzy_dog0 <- system2("/usr/local/bin/twurl", "set default goodsdmbot")
}

post_it()

