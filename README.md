# vim-i18n

Automated translation of Ruby/Rails projects

## Introduction

`vim-i18n` helps you translate your Ruby/Rails project. It just exposes a
single function, `I18nTranslateString`. This function takes the current visual
selection, converts it into a `I18n.t()` call, and adds the proper key in a
specified YAML store.

## Examples

### Extracting translations in `.html.erb` files

```
# app/views/users/show.html.erb
<dt>Name</dt>
    ^^^^
    -> Visual select and `:call I18nTranslateString()`
```

You will be asked for a key. In keeping with Rails translation syntax, if the
key begins with `.` it will be considered a relative key:

```
# app/views/users/show.html.erb
<dt><%= t('.name') %>

# config/locales/en.yml

en:
  users:
    show:
      name: Name
```

### Extracting translations in `.rb` files

Say you have the following line in your codebase:

```
# app/controllers/static_controller.rb
@some_text = "Hello, %{name}!"
             ^^^^^^^^^^^^^^^^^
             -> Visual select this text and `:call I18nTranslateString()`
```

The plugin will first ask you for the I18n key to use (ie. `homepage.greeting`).
Then, if still not specified, the plugin will ask you the location of the YAML
store (ie. `config/locales/en.yml`).

At this point, the plugin will replace the selection, and add the string to the
YAML store:

```
# app/controllers/static_controller.rb
@some_text = I18n.t('homepage.greeting', name: '')
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
             -> BOOM!

# config/locales/en.yml
---
en:
  homepage:
    title: "Hello, %{name}!"
```

Note that the extracted translation included the appropriate interpolation.

### Displaying translation for the key

Let say you have the following key within view / model / controller:

```
# app/controllers/static_controller.rb
@some_text = I18n.t('homepage.greeting', name: '')
                     ^^^^^^^^^^^^^^^^^
```

After selecting and executing `I18nDisplayTranslation()`, the plugin will return you value for the translation.

## Vim mapping

Add this line or a simliar one to your `~.vimrc`:

```vim
vmap <Leader>z :call I18nTranslateString()<CR>
vmap <Leader>dt :call I18nDisplayTranslation()<CR>
```

## Installation

Install via [pathogen.vim](https://github.com/tpope/vim-pathogen), simply copy and paste:

    cd ~/.vim/bundle
    git clone git://github.com/hexatridecimal/vim-i18n.git

For [Janus vim]() simply clone the repo into ~/vim/janus/vim/tools and
add the following to your .vimrc.


```vim
call janus#load_pathogen()
```

Then for either option add a keymap to .vimrc.


```vim
vmap <Leader>x :call I18nTranslateString()<CR>
vmap <Leader>dt :call I18nDisplayTranslation()<CR>
```

And set the path for the rails repo you will be editing.

```
export CURRENT_RAILS_REPO=/Users/yourname/dev/someRailsRepo
```

The locales file at config/locales/en.yml will be edited.
