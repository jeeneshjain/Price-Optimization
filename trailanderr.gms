$ontext
A GAMS model for maximizing profit considering dynamic pricing, demand, and time of sale.
$offtext

Sets
    i 'items' / Aalopuri, Cold_coffee, Frankie, Panipuri, Sandwich, Sugarcane_juice, Vadapav /
    t 'time of day' / Morning, Afternoon, Evening, Night, Midnight /;

Parameters
    p(i) 'selling price per item' / 
        Aalopuri 20, Cold_coffee 40, Frankie 50, Panipuri 20, Sandwich 60, Sugarcane_juice 25, Vadapav 20 /
    c(i) 'cost per item' / 
        Aalopuri 16, Cold_coffee 32, Frankie 40, Panipuri 16, Sandwich 48, Sugarcane_juice 20, Vadapav 16 /
    d(i,t) 'demand for each item at different times' /
        Aalopuri.Morning 215, Aalopuri.Afternoon 226, Aalopuri.Evening 136, Aalopuri.Night 244, Aalopuri.Midnight 223,
        Cold_coffee.Morning 287, Cold_coffee.Afternoon 337, Cold_coffee.Evening 235, Cold_coffee.Night 299, Cold_coffee.Midnight 203,
        Frankie.Morning 204, Frankie.Afternoon 238, Frankie.Evening 240, Frankie.Night 270, Frankie.Midnight 198,
        Panipuri.Morning 233, Panipuri.Afternoon 230, Panipuri.Evening 241, Panipuri.Night 244, Panipuri.Midnight 278,
        Sandwich.Morning 234, Sandwich.Afternoon 164, Sandwich.Evening 206, Sandwich.Night 292, Sandwich.Midnight 201,
        Sugarcane_juice.Morning 260, Sugarcane_juice.Afternoon 325, Sugarcane_juice.Evening 180, Sugarcane_juice.Night 290, Sugarcane_juice.Midnight 223,
        Vadapav.Morning 200, Vadapav.Afternoon 194, Vadapav.Evening 230, Vadapav.Night 190, Vadapav.Midnight 192 /;

Variables
    x(i,t) 'number of units sold of each item at different times',
    TotalProfit 'total profit from selling items';

Positive Variables
    x(i,t);

Equations
    Objective   'Total profit calculation',
    DemandCon(i,t) 'Demand constraint for each item at different times';

Objective..
    TotalProfit =e= sum((i,t), (p(i) - c(i)) * x(i,t));

DemandCon(i,t)..
    x(i,t) =l= d(i,t);

Model ProfitMax /all/;
Solve ProfitMax using LP maximizing TotalProfit;

Display x.l, TotalProfit.l;
