@ScrollAppear = class ScrollAppear
  constructor: (@selector, options = {}) ->
    @ticking = false
    @elements = []
    @defaultToggleClass = options.defaultToggleClass || "hidden"

    @setElements()
    window.addEventListener "scroll", @onScroll

  setElements: ->
    for element in document.querySelectorAll(@selector)
      if appearOffset = element.getAttribute("data-appear-offset")
        @elements.push
          node: element
          offset: parseInt(appearOffset)
          toggleClass:
            element.getAttribute("data-appear-toggle-class") || @defaultToggleClass
      else
        console.warn("Please set a data-appear-offset for #{element.outerHTML}")

  onScroll: =>
    @requestTick() unless @ticking

  requestTick: ->
    requestAnimationFrame(@update)
    @ticking = true

  update: =>
    @scrollY = window.pageYOffset
    @toggleAppearClass element for element in @elements
    @ticking = false

  toggleAppearClass: (element) ->
    if @scrollY >= element.offset
      element.node.classList.remove(element.toggleClass)
    else
      element.node.classList.add(element.toggleClass)

module.exports = @ScrollAppear unless typeof module == "undefined"
