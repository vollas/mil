
module hexagon(radius=10) {
    points = [for (i = [0:5]) [radius * cos(i * 60), radius * sin(i * 60)]];
    polygon(points);
}

hexagon(20);


// Hexagon module with outline
module hexagon_outline(radius=10, thickness=10) {
    outer = [for (i = [0:5]) [radius * cos(i * 60), radius * sin(i * 60)]];
    inner = [for (i = [0:5]) [(radius - thickness) * cos(i * 60), (radius - thickness) * sin(i * 60)]];
    difference() {
        polygon(points=outer);
        polygon(points=inner);
    }
}

// Tiling the hexagons
module hex_tile_grid(rows=5, cols=5, radius=10, thickness=5) {
    dx = 1.5 * radius;
    dy = sqrt(3) * radius;
    for (row = [0:rows-1])
        for (col = [0:cols-1]) {
            x = col * dx;
            y = row * dy + (col % 2) * (dy / 2);
            translate([x, y])
                hexagon_outline(radius, thickness);
        }
}

// Call the tiling module
hex_tile_grid(rows=5, cols=5, radius=50, thickness=10);
