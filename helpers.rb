def time_remaining(reference)
  total_seconds = (reference - Time.now).round
  
  {
    hours: total_seconds / 60 / 60,
    min: total_seconds / 60, 
    seconds: total_seconds % 60
  }
end

def format_time(structured_time)
    structured_time.values
                   .map{ |n| n.to_s.rjust(2, '0') }
                   .join(':')
end

def clear
    system "clear" or system "cls"
end

def insert_space
  3.times { puts }
end
