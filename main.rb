def tokenize(chars)
  chars.gsub('(', ' ( ').gsub(')', ' ) ').split
end

def atom(token)
  Integer token rescue Float token rescue token.to_sym
end

def read_from_tokens(tokens)
  raise SyntaxError, "unexpected ')'" if tokens.length == 0

  token = tokens.shift

  if token == '('
    list = []
    while tokens[0] != ')'
      list.append(read_from_tokens(tokens))
    end  
    tokens.shift
    list
  elsif token == ')'
    raise SyntaxError, "unexpected ')'"
  else
    atom(token)
  end
end

def parse(program)
  read_from_tokens(tokenize(program))
end

