@memory = Hash.new
@memory['passive'] = Hash.new

def denParse mainBlocks

	blocks = Array.new
	blocks = indentationParser(mainBlocks)

	return blocks

end

def indentationParser lines

	blocks = Array.new
	block = Array.new

	lines.each do |line,v|

		lineValue = [line.gsub("\n","").lstrip]
		nesting = line[/\A */].size

		if nesting == 2 then blocks.last.push(lineValue)
		elsif nesting == 4 then blocks.last.last.push(lineValue)
		elsif nesting == 6 then blocks.last.last.last.push(lineValue)
		else blocks.push(lineValue)	end

		nestingPrev = nesting
	end

	return blocksParser(blocks)

end

def blocksParser blocks

	blocks.each do |k,v|

		key = k.split(" ")[0]

		if !key then next end

		if !key.index( /[^[:alnum:]]/ )
			@memory['passive'][key] = Hash.new
			@memory['passive'][key]['params'] = k.sub(key,"").lstrip.split(" ")
			@memory['passive'][key]['return'] = v.last
		else
			blockSolver(k,v)
		end

	end

	return blocks

end


def blockSolver init,block

	key = init.split(" ")[0]
	operator = init.split(" ")[1]
	variable = init.split(" ")[2]
	param = init.split(" ")[3]

	if key == "?"
		if operator != ">"
			if variableRender(variable).to_i > param.to_i
				puts "true"
			else
				puts "false"
			end
		end
	end

	if key == "!"
		puts "log: "+variableRender(init.sub("! ","")).to_s
	end
	if key == "'"
		puts variableRender(init.sub("' ","")).to_s
	end

end

def variableRender key

	if !@memory['passive'][key.split(" ")[0]]
		return key
	end


	varName = key.split(" ")[0]
	varMemory = @memory['passive'][varName]
	varReturn = varMemory['return'].sub(": ","").gsub("\"","")
	varParam = varMemory['params']

	testValue = varReturn.split(" ")[0].index( /[^[:alnum:]]/ )

	# Parse Parameters
	count = 1
	varParam.each do |k,v|
		varReturn = varReturn.sub(k,variableRender(key.split(" ")[count]))
		count += 1
	end

	# Begins with alphanumeric
	if !testValue
		return varReturn
	# An operation
	else
		return operationParser(varReturn)
	end

end

def operationParser init

	key = init.gsub(":","").split(" ")[0]
	init = init.gsub(":","").gsub("+","").gsub("-","").split(" ")

	if key == "+" then return operatorPlus(init) end
	if key == "-" then return operatorMinus(init) end

	return 0
end

def operatorPlus valArray

	# Handle as strings
	if valArray[0].to_i == 0 && valArray[1].to_i == 0
		
		value = ""
		valArray.each do |k,v|
			k = k.gsub("\"","")
			if @memory['passive'][k]
				value += variableRender(k).to_s
			else
				value += k.to_s
			end
		end
		return value

	end

	# As int

	value = 0
	valArray.each do |k,v|
		if @memory['passive'][k]
			value += variableRender(k).to_i
		else
			value += k.to_i
		end
	end
	return value

end

def operatorMinus valArray


	if valArray[0].to_i == 0 && valArray[1].to_i == 0

		value = valArray[0].gsub("\"","")
		valArray.each do |k,v|
			if k == valArray[0] then next end
			k = k.gsub("\"","")
			if @memory['passive'][k]
				value = value.gsub(variableRender(k),"")
			else
				value = value.sub(k,"")
			end
		end
		return value

	end


	value = 0
	valArray.each do |k,v|
		value -= k.to_i
	end
	return value

end













