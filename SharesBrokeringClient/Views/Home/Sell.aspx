<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<SharesBrokeringClient.Models.SharesModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Sell Shares
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Sell Shares</h2>
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
    <div id="sellTab">
       <% using (@Html.BeginForm("Sell", "Home", FormMethod.Post))
{    %>
        <h3>
            <label>Sell</label></h3>
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
        </div>
        <div>
            <label>Amount :</label>
            <input type="text" readonly="readonly" id="amountField" />
        </div>
        <div>
            <input type="button" id="searchButton" value="Cancel" />
            <input type="submit" id="sellButton" value="Sell" />
            <input type="button" id="showAmountButton" value="Trade Amount" />
        </div>
     <%  
} %>
    </div>
    <table id="tblShares" class="sortable">
        <tr>
            <th>Company Name</th>
            <th>Company Symbol</th>
            <th>Purchased Shares</th>
        </tr>
        <%for (var i = 0; i < Model.companyList.Count; i++)
          {  %>
        <tr>
            <td><%=Model.companyList[i].compapnyName %> </td>
            <td align="center"><%=Model.companyList[i].companySymbol %> </td>           
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
            // display search tab on load and hide sell tab
            $("#searchTab").show();
            $("#sellTab").hide();

            // display search tab on click and hide sell tab.
            $('#searchButton').on('click', function () {
                $("#searchTab").show();
                $("#sellTab").hide();
            });

            // Assign table row values to textbox on click of table row.
            // http://www.tutorialized.com/tutorial/How-to-get-row-data-of-html-table-using-jquery/67983
            $('#tblShares').on('click', 'tr', function () {
                $("#searchTab").hide();
                $("#sellTab").show();
                var name = $(this).closest('tr').children('td');
                $('#nameField').val(name.eq(0).text());
                $('#symbolField').val(name.eq(1).text());
                $('#sharesField').val(name.eq(2).text());
            }
            );

            // Filter table based on search company name
            // http://stackoverflow.com/questions/12433304/live-search-through-table-rows
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

            // Filter table based on comapny symbol search
            // http://stackoverflow.com/questions/12433304/live-search-through-table-rows
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

            // Displays the available amount of the suer account.
            //// http://stackoverflow.com/questions/12559515/jquery-ajax-call-to-controller
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

