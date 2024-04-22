# blog-hotwire
simple blog using rails 7 with hotwire

## Versions

| backend                |
|:----------------------:|
| ruby **[3.3.0]**       |
| rails **[7.1.3.2]**      |
| postgresql **[16]** |

## Gems
- simple_form
- tailwindcss-rails
## Development gems
- bullet
- rubocop
- rubocop-performance
- awesome_print
- byebug
- rspec
- annotate
- brakeman
- dotenv
- factory_bot_rails
- letter_opener
```
rubocop --auto-gen-config
```
### Add to .irbrc
```
require "awesome_print"
AwesomePrint.irb!
```
### config/application.rb
```
config.active_record.schema_format = :sql
```
### postgres url 
```
postgresql://ervin:postgres@localhost:5433/blog_hotwire_development
```
### Devise
```
rails generate devise:install
rails generate simple_form:install
```
### Tailwindcss
```
rails generate tailwindcss:install
```
