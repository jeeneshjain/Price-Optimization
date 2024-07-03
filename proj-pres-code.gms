$ontext
A GAMS model for maximizing profit considering dynamic pricing, demand, and time of sale, with added supply constraints.
$offText
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
        Vadapav.Morning 200, Vadapav.Afternoon 194, Vadapav.Evening 230, Vadapav.Night 190, Vadapav.Midnight 192 /
    s(i,t) 'supply limit for each item at different times' /
        Aalopuri.Morning 150, Aalopuri.Afternoon 150, Aalopuri.Evening 100, Aalopuri.Night 150, Aalopuri.Midnight 100,
        Cold_coffee.Morning 300, Cold_coffee.Afternoon 300, Cold_coffee.Evening 200, Cold_coffee.Night 250, Cold_coffee.Midnight 150,
        Frankie.Morning 200, Frankie.Afternoon 200, Frankie.Evening 150, Frankie.Night 200, Frankie.Midnight 150,
        Panipuri.Morning 250, Panipuri.Afternoon 250, Panipuri.Evening 200, Panipuri.Night 250, Panipuri.Midnight 200,
        Sandwich.Morning 200, Sandwich.Afternoon 150, Sandwich.Evening 150, Sandwich.Night 200, Sandwich.Midnight 150,
        Sugarcane_juice.Morning 250, Sugarcane_juice.Afternoon 300, Sugarcane_juice.Evening 200, Sugarcane_juice.Night 250, Sugarcane_juice.Midnight 200,
        Vadapav.Morning 180, Vadapav.Afternoon 180, Vadapav.Evening 150, Vadapav.Night 180, Vadapav.Midnight 150 /;

Variables
    x(i,t) 'number of units sold of each item at different times',
    TotalProfit 'total profit from selling items';

Positive Variables
    x(i,t);

Equations
    Objective   'Total profit calculation',
    DemandCon(i,t) 'Demand constraint for each item at different times',
    SupplyCon(i,t) 'Supply constraint for each item at different times';

Objective..
    TotalProfit =e= sum((i,t), (p(i) - c(i)) * x(i,t));

DemandCon(i,t)..
    x(i,t) =l= d(i,t);

SupplyCon(i,t)..
    x(i,t) =l= s(i,t);

Model ProfitMax /all/;
Solve ProfitMax using LP maximizing TotalProfit;

Display x.l, TotalProfit.l;

