# 使用 httr 包手动获取 access token
library(httr)

# 创建 Spotify API 请求 URL
spotify_token_url <- "https://accounts.spotify.com/api/token"

# 手动请求访问令牌
response <- POST(
  spotify_token_url,
  authenticate(Sys.getenv("82802bdcc162455d86fa426b5dbf1ae9"), Sys.getenv("850d900044784c76b4915cc935b18ff3")),
  body = list(grant_type = "client_credentials"),
  encode = "form"
)

# 检查返回的响应
content(response)

# 提取 access token
access_token <- content(response)$access_token
