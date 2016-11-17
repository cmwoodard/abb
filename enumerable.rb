module Enumerable
	def my_each		
		to_enum(self)if !block_given?
		for x in self
			yield x
		end
	end
		
	def my_each_with_index(*args)			
			to_enum(self)if !block_given?			
			self.my_each{|x,y|	yield x, self.index(x)}		
	end

	def my_select
		to_enum(self)if !block_given?
		
		new_array = []
		self.my_each{|x| new_array.push(x) if yield x}		
		new_array
	end
	
	def my_all?
		if !block_given?
			(self.include?(false) or self.include?(nil)) ? false : true			
		else
			all_true = true
			
			self.my_each{|x|
			if !(yield x)
				all_true = false
			 end
			}		
			all_true
		end
		
	end

	def my_any?
		if !block_given?
			self.include?(true) ? true : false		
		else
			any_true = false
			
			self.my_each{|x|
			if (yield x)
				any_true = true
			 end
			}		
			any_true
		end
	end

	def my_none?
		if !block_given?
			self.include?(true) ? false : true			
		else		
			no_true = true		
			self.my_each{|x|
			if (yield x)
				no_true = false
			 end
			}		
			no_true
		end
	end

	def my_count (*arg, &block)		
		if !block_given?
			if arg.length==0
				ary_1= *(self)
				return ary_1.length
			else
				return arg
			end
		end
		temp_array = self.my_select &block
		return temp_array.length		
	end

	def my_map(proc = nil)
		new = []
    
		for i in self
		  if proc and block_given?
			new << yield(proc.call(i))
		  elsif proc
			new << proc.call(i)
		  elsif block_given?
			new << yield(i)
		  else
			return self
		  end
		end
    
    return new
		
	end

	def my_inject(*args, &block)	
	
		self_array = *(self)
		
		if args[0].is_a?(Symbol)
			memo=args[0]
			value = self_array[0]
			value =0 if args[0].to_s == '+'
			value =1 if args[0].to_s == '*'
		elsif args[0].is_a?(Integer)
			value = args[0]			
			memo=args[1] if args[1].is_a?(Symbol)							
		end		
		
		if !block_given?
			#iterates through all elements
			for x in (0...self_array.length)
				value = value.send("#{memo}", self_array[x])
			end
		else
			for x in (0...self_array.length)				
				value =  yield value, self_array[x]
			end			
		end				
		value
	end

	
end

def multiply_els(ary)
	ary.my_inject(:*)		
end

