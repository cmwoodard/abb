def bubble_sort(array)
	(array.length-1).times{
		(array.length-1).times{|x| array[x], array[x+1]=array[x+1], array[x] if array[x+1]< array[x]}
	}	
		puts array.inspect

end
 def bubble_sort_by(array)
	(array.length-1).times{
		(array.length-1).times{|x| array[x], array[x+1]=array[x+1], array[x] if yield(array[x], array[x+1])>0}
	}	
		array
end
 
 bubble_sort_by(["hi","hello","hey"]) do |left,right|
	left.length - right.length
 end
 
#bubble_sort([4,3,78,2,0,2])