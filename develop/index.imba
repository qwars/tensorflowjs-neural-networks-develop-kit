Imba:HTML_TAGS.push 'dialog'
Imba:HTML_TAGS.push 'center'

Imba:HTML_ATTRS:hr = 'open'
Imba:HTML_ATTRS:nav = 'open'
Imba:HTML_ATTRS:menu = 'open'
Imba:HTML_ATTRS:aside = 'open'
Imba:HTML_ATTRS:dialog = 'open'

import './stylesheets'

import './index.styl'

import 'imba-router'

# ISVG = require './images/symbol-icons.svg'

import Application from './application'

import Sketch as Header from './header'
import Sketch as Main from './main'
import Sketch as Footer from './footer'

Imba.mount <Application route="{ Imba.root.router.root }/*:collection*/*:document*/*">
Imba.mount <Header route="{ Imba.root.router.root }/*:collection*/*:document*/*">
Imba.mount <Main route="{ Imba.root.router.root }/*:collection*/*:document*/*">
Imba.mount <Footer route="{Imba.root.router.root}/*:collection*/*:document*/*">

