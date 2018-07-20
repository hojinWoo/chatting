`rails _4.2.10_ new chatservice`

`figaro install`

`rails g devise:install`

`rails g devise users`

`rails g scaffold chat_room title master_id max_count:integer admission_count:integer`

`rails g model chat user:references chat_room:references message:text`

`rails g model admission user:references chat_room:references`
