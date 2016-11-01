%%==========================================================================
%%==========================================================================

-module(bus_card).

-export([bus_card/0]).

-define(PDF_DIR, "./pdf/bus_card.pdf").

bus_card()->
    PDF = eg_pdf:new(),
    eg_pdf:set_pagesize(PDF,a4),
    eg_pdf:set_fill_gray(PDF,0.75),
    eg_pdf:set_line_width(PDF, 1),
    crop_bus_card(PDF),
    {Serialised, _PageNo} = eg_pdf:export(PDF),
    file:write_file(?PDF_DIR,[Serialised]),
    eg_pdf:delete(PDF).

crop_bus_card(PDF) ->
    crop(PDF, 75, 550,144, 252),
    crop(PDF, 275, 650,252, 144).

crop(PDF, X, Y, W, H) ->
    Extend = 10,
    % Lower left
    eg_pdf:line(PDF, X - Extend, Y, X + Extend, Y),
    eg_pdf:line(PDF, X, Y - Extend, X, Y + Extend),
    % Upper left
    eg_pdf:line(PDF, X - Extend, Y + H, X + Extend, Y + H),
    eg_pdf:line(PDF, X, Y - Extend + H, X, Y + Extend + H),
    % Upper right
    eg_pdf:line(PDF, X - Extend + W, Y + H, X + Extend + W, Y + H),
    eg_pdf:line(PDF, X + W, Y - Extend + H, X + W, Y + Extend + H),
    % Lower 
    eg_pdf:line(PDF, X - Extend + W, Y, X + Extend + W, Y),
    eg_pdf:line(PDF, X + W, Y - Extend, X + W, Y + Extend).
  
