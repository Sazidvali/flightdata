<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Flight Table</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
    <div class="container">
        <h2>Flight Table</h2>
        <div class="form-group">
            <label for="flightTiming">Flight Timing:</label>
            <select class="form-control" id="flightTiming">
                <option value="">All</option>
                <option value="Morning">Morning</option>
                <option value="Afternoon">Afternoon</option>
                <option value="Evening">Evening</option>
                <option value="Night">Night</option>
            </select>
        </div>
        <div class="form-group">
            <label for="flightName">Flight Name:</label>
            <input type="text" class="form-control" id="flightName">
        </div>
        <div class="form-group">
            <label for="flightStop">Flight Stop:</label>
            <select class="form-control" id="flightStop">
                <option value="">All</option>
                <option value="Direct">Direct Flight</option>
                <option value="Indirect">Indirect Flight</option>
            </select>
        </div>
        <table class="table table-bordered" id="flightTable">
            <thead>
                <tr>
                    <th>Flight Name</th>
                    <th>Flight Timing</th>
                    <th>Flight Stop</th>
                    <th>Price</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>

    <script>
        $(document).ready(function() {
            loadData();

            $('#flightTiming, #flightName, #flightStop').change(function() {
                loadData();
            });
        });

        function loadData() {
            var timing = $('#flightTiming').val();
            var name = $('#flightName').val();
            var stop = $('#flightStop').val();

            $.ajax({
                url: 'FlightDataServlet', // Replace with your Servlet URL
                type: 'POST',
                data: {
                    timing: timing,
                    name: name,
                    stop: stop
                },
                success: function(response) {
                    updateTable(response);
                },
                error: function(xhr, status, error) {
                    console.error(xhr.responseText);
                }
            });
        }

        function updateTable(data) {
            var tableBody = $('#flightTable tbody');
            tableBody.empty();

            if (data.length > 0) {
                $.each(data, function(index, flight) {
                    var row = '<tr>' +
                        '<td>' + flight.name + '</td>' +
                        '<td>' + flight.timing + '</td>' +
                        '<td>' + flight.stop + '</td>' +
                        '<td>' + flight.price + '</td>' +
                        '</tr>';
                    tableBody.append(row);
                });
            } else {
                var row = '<tr><td colspan="4">No flights found.</td></tr>';
                tableBody.append(row);
            }
        }
    </script>
</body>
</html>