require 'rubygems'
require 'sinatra'

=begin
# This is a Rock, Paper, Scissors Ruby App
# Found at: 
# https://gist.github.com/citizen428/86780
# and modified to run in OpenShift (Enterprise) v3
=end

set :bind, '0.0.0.0'
set :port, 8080

get '/' do
  erb :index
end

post '/' do
  erb :index
end

get '/*' do
  redirect '/'
end

__END__
@@ layout
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<title>Rock-Paper-Scissors</title>
</head>
<body>
	<%= yield %>
</body>
</html>

@@ index
<p>Select:</p>
<form action="/" method="post" accept-charset="utf-8">
    <button type="submit" value="rock" name="game">Rock</button>
    <button type="submit" value="paper" name="game">Paper</button>
    <button type="submit" value="scissors" name="game">Scissors</button>
</form>
<%
  if @env["REQUEST_METHOD"] == 'POST'
    @options = { :rock => :scissors, :paper => :rock, :scissors => :paper }
    @comp = [:rock, :paper, :scissors][rand(3)]
    @html = ''
    
    @html << "<p>You chose #{params[:game].capitalize} and the computer chose #{@comp.to_s.capitalize}:</p>"  
    @html << '<p><b>'
    if @comp == params[:game].intern
      @html << 'Tie! :-/'
    elsif @comp == @options[params[:game].intern]
      @html << 'You win! :-)'
    else 
      @html << 'You loose! :-('
    end 
    @html << '</b></p>'
  end
%>
<%= @html %>

