<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<SharesBrokeringClient.Models.SharesModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    List
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>List</h2>
    <div id="searchTab">
        <h2>Search</h2>
         <div>
            <label>Comapany Name :</label>
            <input type="text" id="searchNameField" />
        </div>
        <div>
            <label>Comapany Symbol :</label>
            <input type="text" id="searchSymbolField" />
        </div>
        <div>
            <label>Number of Shares :</label>
            <input type="text" id="searchSharesField" />
        </div>
        <div>
            <label>Amount :</label>
            <input type="text" id="searchAmountField" />
        </div>
    </div>
    <div id="buyTab">
        <h2>Buy</h2>
        <div>
            <label>Comapany Name :</label>
            <input type="text" id="nameField" />
        </div>
        <div>
            <label>Comapany Symbol :</label>
            <input type="text" id="symbolField" />
        </div>
        <div>
            <label>Number of Shares :</label>
            <input type="text" id="sharesField" />
        </div>
        <div>
            <label>Amount :</label>
            <input type="text" id="amountField" />
        </div>
        <div>
            <input type="button" id="searchButton" value="Search" />
            <input type="button" id="buyButton" value="Buy" />
        </div>
    </div>
    <table id="tblTest" class="sortable">
        <tr>
            <th>Company Name</th>
            <th>Company Symbol</th>
            <th>Share Price</th>
            <th>Available Shares</th>
        </tr>
        <%for (var i = 0; i < Model.companyList.Count; i++)
          {  %>
        <tr>
            <td><%=Model.companyList[i].compapnyName %> </td>
            <td align="center"><%=Model.companyList[i].companySymbol %> </td>
            <td align="center"><%=Model.companyList[i].sharePrice.value %> </td>
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
            $("#searchTab").show();
            $("#buyTab").hide();
            $('#searchButton').on('click', function () {
                $("#searchTab").show();
                $("#buyTab").hide();
            });
            //$('#expand').on("click", function () {
            //    this.style.height = 'auto';
            //});
            //$('#selectRow').on("click", function () {
            //$('table td:nth-child(1)').live('click', function (event) {
            $('#tblTest').on('click', 'tr', function () {
                //alert("hi");
                //$("#tblTest td:nth-child(1)").click(function(event){
                $("#searchTab").hide();
                $("#buyTab").show();
                var name = $(this).closest('tr').children('td');
                $('#nameField').val(name.eq(0).text());
                $('#symbolField').val(name.eq(1).text());
                $('#amountField').val(name.eq(2).text());
                $('#sharesField').val(name.eq(3).text());
            }
            );

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
        });
    </script>
</asp:Content>

