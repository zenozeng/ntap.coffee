end = move = start = {}
count = timeout = null

document.addEventListener 'touchstart', (event) ->
  start = event
  count = 0 unless (start.timeStamp - end.timeStamp < 350) # Last tap was too old
  clearTimeout(timeout) if timeout? # Cancel the dispatch of event when tap again

document.addEventListener 'touchmove', (event) -> move = event

document.addEventListener 'touchend', (event) ->
  end = event
  ++count
  return if end.timeStamp - start.timeStamp < 1 # invalid tap
  return if end.timeStamp - start.timeStamp > 600 # holding
  return if move.timeStamp > start.timeStamp # move
  event = new CustomEvent("tap"+count, {bubbles: true, cancelable: true})
  fn = -> start.target.dispatchEvent(event)
  timeout = setTimeout fn, 300
