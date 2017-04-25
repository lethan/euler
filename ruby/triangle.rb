def largestTrianglePath(filename)
  file = File.open(filename, "r")
  triangle = []
  while line = file.gets
    line = line.split.map!(&:to_i)
    triangle << line
  end
  file.close

  triangle.reverse!

  triangle.each_with_index do |outer, index|
    if outer.length > 1 then
      outer.each_with_index do |inner, i|
        triangle[index+1][i] += [inner, outer[i+1]].max unless i == outer.length - 1
      end
    end
  end

  triangle.last.first
end