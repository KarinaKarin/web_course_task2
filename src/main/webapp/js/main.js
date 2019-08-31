(function () {
    function Plot(canvasElement, radius, checks) {
        function xTickDelta() {
            return 1 ;
        }

        function yTickDelta() {
            return 1 ;
        }

        function maxX() {
            return 7 ;
        }

        function minX() {
            return -7 ;
        }

        function maxY() {
            return 7;
        }

        function minY() {
            return -7;
        }

        function convertX(x) {
            return (x - minX()) / (maxX() - minX()) * width;
        }

        function convertY(y) {
            return height - (y - minY()) / (maxY() - minY()) * height;
        }

        function parseX(x) {
            return x / width * (maxX() - minX()) + minX();
        }

        function parseY(y) {
            return -((y - height) / height * (maxY() - minY()) + maxY());
        }

        function drawYAxis(context) {
            context.beginPath();
            context.moveTo(convertX(0), convertY(minY()));
            context.lineTo(convertX(0), convertY(maxY()));
            context.stroke();
        }

        function drawXAxis(context) {
            context.beginPath();
            context.moveTo(convertX(minX()), convertY(0));
            context.lineTo(convertX(maxX()), convertY(0));
            context.stroke();
        }

        function drawMarksOnYAxis(context) {
            var delta = yTickDelta();
            for (var i = minY() + 1; (i * delta) < maxY(); ++i) {
                context.beginPath();
                context.moveTo(convertX(0) - 5, convertY(i * delta));
                context.lineTo(convertX(0) + 5, convertY(i * delta));
                context.stroke();

                if (i !== 0) {
                    context.fillText(i, convertX(0) + 6, convertY(i * delta) + 3);
                }
            }
        }

        function drawMarkOnXAxis(context) {
            var delta = xTickDelta();
            for (var i = minX() + 1; (i * delta) < maxX(); ++i) {
                context.beginPath();
                context.moveTo(convertX(i * delta), convertY(0) - 5);
                context.lineTo(convertX(i * delta), convertY(0) + 5);
                context.stroke();

                if (i !== 0) {
                    context.fillText(i, convertX(i * delta) - 4, convertY(0) - 6);
                }
            }
        }

        function drawAxes(context) {
            context.save();
            context.lineWidth = 1;
            context.font = "12px Arial";
            drawYAxis(context);
            drawXAxis(context);
            drawMarksOnYAxis(context);
            drawMarkOnXAxis(context);
            context.restore();
        }

        function drawFigure(context, radius) {
            context.save();
            context.fillStyle = '#425aff';
            context.beginPath();
            context.moveTo(convertX(0), convertY(radius));
            context.lineTo(convertX(radius), convertY(radius));
            context.lineTo(convertX(radius), convertY(0));
            context.lineTo(convertX(0), convertY(-radius / 2));
            context.lineTo(convertX(0), convertY(0));
            context.arc(convertX(0), convertY(0), (radius / 2) * (width / (maxX() - minX())), Math.PI, 3 * Math.PI / 2);
            context.lineTo(convertX(0), convertY(0));
            context.lineTo(convertX(0), convertY(radius));
            context.closePath();
            context.fill();
            context.restore();
        }

        function drawDots(context) {
            context.save();

            checks.forEach(function (check) {
                context.beginPath();
                context.moveTo(convertX(check.x), convertY(check.y));
                context.arc(convertX(check.x), convertY(check.y), 2, 0, 2 * Math.PI);
                context.closePath();
                if (check.result) {
                    context.fillStyle = '#00FF00';
                } else {
                    context.fillStyle = '#FF0000';
                }

                context.fill();
            });

            context.restore();
        }

        function draw(context) {
            if (radius) {
                drawFigure(context, radius);
            }
                drawAxes(context);

            if (checks) {
                drawDots(context);
            }
        }

        this.element = canvasElement;
        this.context = null;

        this.draw = function () {
            this.context.clearRect(0, 0, width, height);
            draw(this.context);
        };

        this.setRadius = function (r) {
            radius = r;
            this.draw();
        };

        this.addClickHandler = function (callback) {
            this.element.addEventListener('click', function (clickEvent) {
                if (callback)
                    callback({
                        x: Math.round(parseX(clickEvent.offsetX) * 1000) / 1000,
                        y: Math.round(parseY(clickEvent.offsetY) * 1000) / 1000,
                        r: radius
                    });
            })
        };

        var width = this.element.width;
        var height = this.element.height;

        if (this.element && this.element.getContext) {
            this.context = this.element.getContext('2d');
            this.draw();
        }
    }

    window.addEventListener('load', function (ev) {
        var radiusCheckboxes = document.querySelectorAll('input[type="checkbox"][name="r"]');
        var yTextInput = document.querySelector('input[type="text"][name="y"]');
        var radius = 0;
        if (window.r != null){
            radius = r;
        }
        var plot = null;

        if (radiusCheckboxes) {
            radiusCheckboxes.forEach(function (radiusCheckbox) {
                if (radiusCheckbox.checked) radius = radiusCheckbox.value;

                radiusCheckbox.addEventListener('change', function (changeEvent) {
                    radiusCheckboxes.forEach(function (radioButton) {
                        radioButton.checked = false;
                    });

                    radiusCheckbox.checked = true;
                    radius = radiusCheckbox.value;
                    if (plot) plot.setRadius(radius);
                });
            });
        }

        if (yTextInput) {
            yTextInput.addEventListener('keypress', function (keyPressEvent) {
                var newValue = yTextInput.value + keyPressEvent.key;
                if (!/^[+-]?[0-5]?$/.test(newValue)) {
                    keyPressEvent.stopImmediatePropagation();
                    keyPressEvent.preventDefault();
                }
            });
        }

        plot = new Plot(document.getElementById('plot'), radius , window.checks);
        plot.addClickHandler(function (event) {
            window.location.href = window.contextApi + '/index?x=' + event.x + '&y=' + event.y + '&r=' + event.r;
        })
    })
})();