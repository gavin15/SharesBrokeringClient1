<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<SharesBrokeringClient.Models.SharesModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Buy Shares
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Buy Shares</h2>
    <hgroup class="title">
        <h2 class="error"><%=TempData["LoginError"] %></h2>
    </hgroup>
    <div id="searchTab">
        <h3>
            <label>Search</label></h3>
        <div>
            <label>Company Name :</label>
            <input type="text" id="searchNameField" />
        </div>
        <div>
            <label>Company Symbol :</label>
            <input type="text" id="searchSymbolField" />
        </div>
    </div>
    <div id="buyTab">
        <% using (@Html.BeginForm("Buy", "Home", FormMethod.Post))
           {    %>
        <h3>
            <label>Buy</label></h3>
        <div>
            <label>Comapany Name :</label>
            <%= Html.TextBoxFor(t => t.compapnyName, new { id="nameField",@readonly="readonly"}) %>
        </div>
        <div>
            <label>Comapany Symbol :</label>
            <%= Html.TextBoxFor(t => t.companySymbol, new { id="symbolField",@readonly="readonly"}) %>
        </div>
        <div>
            <label>Number of Shares :</label>
            <%= Html.TextBoxFor(t => t.noOfShares, new { id="sharesField"}) %>
            <%= Html.HiddenFor(t => t.sharePrice.value, new { id="sharesValue"}) %>
            <%= Html.HiddenFor(t => t.sharePrice.currency, new { id="sharesCurrency"}) %>
        </div>
        <div>
            <label>Amount :</label>
            <input type="text" readonly="readonly" id="amountField" />
        </div>
        <div>
            <input type="button" id="searchButton" value="Cancel" />
            <input type="button" id="totalButton" value="Total Amount" />
            <input type="submit" id="buyButton" value="Buy" />
            <input type="button" id="showAmountButton" value="Trade Amount" />
        </div>
        <%  
} %>
    </div>
    <table id="tblShares" class="sortable">
        <tr>
            <th>Company Name</th>
            <th>Company Symbol</th>
            <th>Share Price</th>
            <th>Currency</th>
            <th>Available Shares</th>
        </tr>
        <%for (var i = 0; i < Model.companyList.Count; i++)
          {  %>
        <tr>
            <td><%=Model.companyList[i].compapnyName %> </td>
            <td align="center"><%=Model.companyList[i].companySymbol %> </td>
            <td align="center"><%=Model.companyList[i].sharePrice.value %> </td>
            <td align="center"><%=Model.companyList[i].sharePrice.currency %> </td>
            <td align="center"><%=Model.companyList[i].availableShares %> </td>
            <td>
                <input type="button" id="selectRow" value="Select" /></td>
        </tr>
        <%} %>
    </table>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <script src="../../Scripts/sorttable.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            // Display search tab on load and hide buy tab
            $("#searchTab").show();
            $("#buyTab").hide();

            // Display search tab on click and hide buy tab
            $('#searchButton').on('click', function () {
                $("#searchTab").show();
                $("#buyTab").hide();
            });

            // Assign values of table row to the texboxes.
            //http://www.tutorialized.com/tutorial/How-to-get-row-data-of-html-table-using-jquery/67983
            $('#tblShares').on('click', 'tr', function () {
                $("#searchTab").hide();
                $("#buyTab").show();
                var name = $(this).closest('tr').children('td');
                $('#nameField').val(name.eq(0).text());
                $('#symbolField').val(name.eq(1).text());
                $('#sharesValue').val(name.eq(2).text());
                $('#sharesCurrency').val(name.eq(3).text());
                $('#sharesField').val(name.eq(4).text());
            }
            );

            // filter the table based on company name search
            //http://stackoverflow.com/questions/12433304/live-search-through-table-rows
            $('#searchNameField').on("keyup", function () {
                var value = $(this).val();

                $("table tr").each(function (index) {
                    if (index != 0) {

                        $row = $(this);

                        var id = $row.find("td:first").text();

                        if (id.indexOf(value) != 0) {
                            $(this).hide();
                        }
                        else {
                            $(this).show();
                        }
                    }
                });
            });

            // Filter the table based on company symbol search
            //http://stackoverflow.com/questions/12433304/live-search-through-table-rows
            $('#searchSymbolField').on("keyup", function () {
                var value = $(this).val();

                $("table tr").each(function (index) {
                    if (index != 0) {

                        $row = $(this);

                        var id = $row.find("td:nth-child(2)").text();

                        if (id.indexOf(value) != 0) {
                            $(this).hide();
                        }
                        else {
                            $(this).show();
                        }
                    }
                });
            });

            // Ajax call to fetch the total amount from the service on click of total button.
            // http://stackoverflow.com/questions/12559515/jquery-ajax-call-to-controller
            $('#totalButton').on('click', function () {
                var noOfshares = $('#sharesField').val();
                var currency = $('#sharesCurrency').val();
                var shareValue = $('#sharesValue').val();
                $.ajax({
                    type: 'GET',
                    url: '/Home/GetTotal',
                    data: { shares: noOfshares, price: shareValue, currency: currency },
                    cache: false,
                    success: function (result) {
                        $('#amountField').val(result);
                    }
                });
            });

            // Ajax call to fetch the available amount for the user.
            // http://stackoverflow.com/questions/12559515/jquery-ajax-call-to-controller
            $('#showAmountButton').on('click', function () {
                $.ajax({
                    type: 'GET',
                    url: '/Home/GetUserAmount',
                    cache: false,
                    success: function (result) {
                        alert("Total amount available is : " + result);
                    }
                });
            });
        });
    </script>
</asp:Content>

