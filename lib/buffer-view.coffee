_ = require 'underscore-plus'
XobFuzzyFinderView = require './xob-fuzzy-finder-view'

module.exports =
class BufferView extends XobFuzzyFinderView
  toggle: ->
    if @panel?.isVisible()
      @cancel()
    else
      @populate()
      @show() if @paths?.length > 0

  getEmptyMessage: (itemCount) ->
    if itemCount is 0
      'No open editors'
    else
      super

  populate: ->
    editors = atom.workspace.getTextEditors().filter (editor) -> editor.getPath()?
    activeEditor = atom.workspace.getActiveTextEditor()
    editors = _.sortBy editors, (editor) ->
      if editor is activeEditor
        0
      else
        -(editor.lastOpened or 1)

    @paths = editors.map (editor) -> editor.getPath()
    @setItems(_.uniq(@paths))
