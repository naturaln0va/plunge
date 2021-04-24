
function clamp(val, lower, upper)
  assert(val and lower and upper, 'missing required params')
  if lower > upper then lower, upper = upper, lower end -- swap if boundaries supplied the wrong way
  return math.max(lower, math.min(upper, val))
end

function approach(val, target, amt)
  assert(val and amt and target, 'missing required params')
  if target > val then
    local result = val + amt
    if result >= target then
      return target
    else
      return result
    end
  else
    local result = val - amt
    if result <= target then
      return target
    else
      return result
    end
  end
end

function boolToNumber(value)
  return value and 1 or 0
end
