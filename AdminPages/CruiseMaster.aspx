<%@ Page Language="C#" MasterPageFile="~/AdminPages/AdminMasterPage.master" Title="Cruise Master"  AutoEventWireup="true" CodeFile="CruiseMaster.aspx.cs" Inherits="AdminPages_CruiseMaster" enableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <script src="../JS/jquery-1.11.2.min.js"></script>
 
    <script src="../JS/jquery.dataTables.js"></script>
   
     <script src="../JS/dataTables.responsive.min.js"></script>
        <script src="../JS/dataTables.tableTools.min.js"></script>
       <script src="../JS/dataTables.bootstrap.js"></script>
    <link href="../Css/dataTables.bootstrap.css" rel="stylesheet" />
      <%--  <script src="../JS/dataTables.colVis.min.js"></script>--%>
        <script src="../JS/dataTables.buttons.min.js"></script>
  <%--    <script src="../AdminContent/JS/select2.full.min.js"></script>--%>
    <link href="../Css/bootstrap-select.min.css" rel="stylesheet" />
    <script src="../AdminContent/JS/bootstrap-select.min.js"></script>
    <script src="../JS/bootstrap.min.js"></script>
    <link href="../Css/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" />
 <link href="../Css/dataTables.bootstrap.css" rel="stylesheet" />
     <link href="../Css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="../css/multi-form.css">
    
     <link rel="stylesheet" href="../css/AdminLTE.min.css">
        <script src="../AdminContent/JS/Cruise.js"></script>
 

    <style>
        
	.loading-text{
                color: #000;
    font-weight: 700;
    letter-spacing: .5px;
    margin: 7px 5px 0;
        }
            .processing-bar-holder {
    position: fixed;
    top: 0;
    width: 300px;
    text-align: center;
    padding: 0;
    z-index: 2501;
    bottom: 0;
    height: 10px;
    margin: auto;
    left: 0;
    right: 0;
    height: 50px;
    background-color: rgba(255,255,255,0.9);
}
        .processing-bar {
    display: block;
    margin: 0 auto;
    border-bottom-left-radius: 5px;
    border-bottom-right-radius: 5px;
    padding: 0 10px;
    background-color: #00b0ef;
    text-align: center;
    color: #fff;
    font-size: 12px;
    position: relative;
}
        .bg-holder{
                  position: relative;
    background-color: #32404e;
    height: 9px;
    margin-top: 6px;
        }

        #myProgress {
            width: 100%;
            background-color: transparent;
        }

        #myBar {
           
            width: 1%;            
    height: 9px;
    background-color: #5195c5;   
    border-radius: 0;    
    position: relative;
        }
        .modaloverlay{
    background:transparent url(../images/overlay.png) repeat top left;
    position:fixed;
    top:0px;
    bottom:0px;
    left:0px;
    right:0px;
    z-index:1000;
    width:100%;
    height:100%;
    display:block;
    background-color:rgb(0,0,0);
    opacity:0.75;
}

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <section class="content">
      <asp:HiddenField ID="hdnTripId" runat="server" />
	<!--<div class="container">-->
         <div class="modaloverlay" id="modaloverlay"></div>
         <div id="processing-bar-holder" class="clearfix processing-bar-holder collapse">
            <div class="processing-bar" id="myProgress">
                <p class="loading-text">Uploading Files</p>
                <div class="bg-holder" style="display: none">
                    <div id="myBar"></div>
                </div>                
            </div>
        </div>
	<div class="box box-primary">
		<div class="box-body">
			<div class="container">
				<div class="stepwizard">
					<div class="stepwizard-row setup-panel">
						<div class="stepwizard-step col-xs-2"> 
							<a href="#step-1" id="1" type="button" class="btn btn-success btn-circle">1</a>
							<p><small>Cruise Details</small></p>
						</div>
						<div class="stepwizard-step col-xs-2"> 
							<a href="#step-2" id="2" type="button" class="btn btn-default btn-circle" disabled="disabled">2</a>
							<p><small>Cabin Pricing</small></p>
						</div>
						<div class="stepwizard-step col-xs-2"> 
							<a href="#step-3" id="3" type="button" class="btn btn-default btn-circle" disabled="disabled">3</a>
							<p><small>Itenary Details</small></p>
						</div>
						<div class="stepwizard-step col-xs-2"> 
							<a href="#step-4" id="4" type="button" class="btn btn-default btn-circle" disabled="disabled">4</a>
							<p><small>On Board Activities</small></p>
						</div>
                        <div class="stepwizard-step col-xs-2"> 
							<a href="#step-5" id="5" type="button" class="btn btn-default btn-circle" disabled="disabled">5</a>
							<p><small>Cabins</small></p>
						</div>
                        <div class="stepwizard-step col-xs-2"> 
							<a href="#step-6" id="6" type="button" class="btn btn-default btn-circle" disabled="disabled">6</a>
							<p><small>Ship General Info</small></p>
						</div>
					</div>
				</div>
				
				<form role="form">
					<div class="panel panel-primary setup-content" id="step-1">
						<div class="panel-heading">
							 <h3 class="panel-title">Cruise Details</h3>
						</div>
						<div class="panel-body">
                            <div class="row">
                                <div class="col-sm-4">
						            <div class="form-group">
							            <label for="title-name">Title</label>
							            <input type="text" class="form-control" id="title-name" placeholder="Enter title">
						            </div>
					            </div>
					            <div class="col-sm-4">
                                    <div class="form-group col-sm-6">
							            <label for="noDays">No.of Days</label>
							            <input type="number" class="form-control integer" id="days" placeholder="Enter No. of Days">
                                    </div>
                                    <div class="form-group col-sm-6">
							            <label for="noNights">No.of Nights</label>
							            <input type="number" class="form-control integer" id="nights" placeholder="Enter No.of Nights">
                                     </div>
					            </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
							            <label for="noNights">Detail For</label>
							            <input type="text" class="form-control" id="detail-for" placeholder="Enter Title Details">
                                     </div>
					            </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-4">
						            <div class="form-group">
						              <label for="pd-image">Upload Images</label>
						              <input type="file" id="pd-image" multiple>
						              <p class="help-block">Only .png & .jpg is Supported.<br /> Multiple selection of images are allowed</p>
						            </div>
					            </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
									  <label>Source Port</label>
									  <select class="form-control dropdown-list selectpicker select2" data-live-search="true" id="ddlSourceCountry" style="width: 100%;">
										
									  </select>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="form-group">
									  <label>Destination Port</label>
									  <select class="form-control dropdown-list selectpicker select2" data-live-search="true" id="ddlDestinationCountry" style="width: 100%;">
										
									  </select>
									</div>
								</div>
                            </div>

                            <div class="row">
                                <div class="col-sm-4">
									<div class="form-group">
									  <label>Company Name</label>
									  <select class="form-control dropdown-list selectpicker select2" data-live-search="true" id="ddlCompany" style="width: 100%;">
										
									  </select>
									</div>
								</div>
                                <div class="col-sm-4">
						            <label for="noDays">Tax Per Person</label>
							        <input type="text" class="form-control integer" id="tax" placeholder="Enter Tax Per Person">
					            </div>
                                
								<div class="col-sm-4">
                                    <div class="col-sm-6 form-group">
									  <label>Gratuity Adult(> 15 yrs)</label>
							          <input type="text" class="form-control integer" id="GratAbFive" placeholder="Enter for Adult">
									</div>
									<div class="col-sm-6 form-group">
									  <label>Gratuity Child(4-14 yrs)</label>
							          <input type="text" class="form-control integer" id="GratChild" placeholder="Enter for Child">
									</div>
								</div>
                            </div>

                            <div class="row">
						        <div class="form-group col-sm-6">
							        <label class="control-label">Inclusion</label>
							        <textarea runat="server" class="inc-text" placeholder="Inclusion" name="inclusion" id="inclusion" style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"></textarea>
						        </div>
                                <div class="form-group col-sm-6">
							        <label class="control-label">Exclusion</label>
							        <textarea runat="server" class="inc-text" placeholder="Exclusion" name="exclusion" id="exclusion" style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"></textarea>
						        </div>
					        </div>	
                            <%--<div class="col-sm-12">
                                <label style="color: orangered" name="CruiseMessage" id="BTBMessage"></label>
                                    <br />
						        <button type="submit" id="btnSubmit"class="btn btn-primary">Add Cruise Master Details</button>
                                <button type="submit" id="btnUpdate"class="btn btn-primary">Update Cruise Master Details</button>
                                <button type="submit" id="btnCancel"class="btn btn-primary">Cancel</button>
					        </div>--%>					
                            <label style="color: orangered" name="CruiseDetailMsg" id="CruiseDetailMsg"></label>
                            <br />
							<button class="btn btn-primary nextBtn pull-right" type="button" id="btnTab1">Next</button>
						</div>
					</div>
					
					<div class="panel panel-primary setup-content" id="step-2">
						<div class="panel-heading">
							 <h3 class="panel-title">Cabin Pricing</h3>
						</div>
						<div class="panel-body">
							
                            <div class="form-group">
                                <div id="newcruise">
                                <div class="row">
                                     
                                <div class="col-sm-12">
                                 <%-- <div class="col-sm-2">Select Dates </div> <div class="col-sm-3"><input type="text" id="inpFromDate" placeholder="Start Date" class=" daterange-picker" /></div><div class="col-sm-3"><input type="text" id="inpToDate" placeholder="End Date" class="daterange-picker" /></div>--%>
                                    <div class="col-sm-4"><button id="btnAddDDates"  class="btn btn-primary nextBtn"> Add Dates</button></div> 
                                </div>
                                    </div>
                                <div class="row">
                                <div class="col-sm-12">
                                  <%--<div class="col-sm-3"><input type="checkbox" id="allCheck" name="cabin" value="All" />All </div>--%> 
                                <%--    <div class="col-sm-3"><input type="checkbox" name="cabin" id="InteriorCheck" class="allCabin" value="1" />Interior </div>
                                    <div class="col-sm-3"><input type="checkbox" id="OceanCheck" class="allCabin" name="cabin" value="2" />OceanView </div>
                                    <div class="col-sm-3"><input type="checkbox" id="balconyCheck" name="cabin" class="allCabin" value="3"/>Balcony </div>
                                    <div class="col-sm-3"><input type="checkbox" id="SuiteCheck" name="cabin" class="allCabin" value="4" />Suite </div> --%>
                                </div>
                                </div>
                                <div class="row">
                                     <label style="color: orangered" name="dateMsg" id="dateMsg"></label>
                                </div>
                                </div>
                                <fieldset>
                                <div id="cruseDates" >
                                     <div class="col-sm-7 table-responsive">
                                     <table id="tblDates" class="table table-bordered">
                                            <thead>
                                                <tr class="alert-info">
                                                    <td style="text-align:center" class="hidden">Sr No.</td>
                                                    <td style="text-align:center">Start Date</td>
                                                    <td style="text-align:center">End Date</td>
                                                    <td style="text-align:center">Price</td>
                                                     <td style="text-align:center">Edit</td>
                                                    <td style="text-align:center" width="50px;">Delete</td>
                                                    
                                                </tr>
                                            </thead>
                                            <tbody>
                                                
                                            </tbody>
                                        </table>
                                         </div>
                                </div>
                                    </fieldset>
								<%--<fieldset id="interiorDiv" class="hidden">
                                    <legend>Interior</legend>
                                    <div class="col-sm-7 table-responsive">
                                        <table id="tbl-Int" class="table table-bordered">
                                            <thead>
                                                <tr class="alert-info">
                                                    <td style="text-align:center">Sr No.</td>
                                                    <td style="text-align:center">Start Date</td>
                                                    <td style="text-align:center">End Date</td>
                                                    <td style="text-align:center">Twin Cabin Price</td>
                                                    <td style="text-align:center" width="50px;">Delete</td>
                                                    <td style="display:none;"></td>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                
                                            </tbody>
                                        </table>
                                       <label style="color: orangered" name="CabIntMsg" id="CabIntMsg"></label>
                                       <br />
                                    </div>
                                   <div class="col-sm-1">
                                        <button class="btn btn-primary nextBtn hidden" id="AddRowInt" type="button">Add Row</button>
                                    </div>
                                   <%-- <div class="col-sm-3">
						                <div class="form-group">
						                  <label for="pd-image">Upload Images</label>
						                  <input type="file" id="Int-image">
						                  <p class="help-block">Only .png & .jpg is Supported</p>
						                </div>
					                </div>--%>
								<%--</fieldset>--%>

                              <%--  <fieldset id="OceanDiv" class="hidden">
                                    <legend>Oceanview</legend>
                                    <div class="col-sm-7 table-responsive">
                                        <table id="tbl-Ocean" class="table table-bordered">
                                            <thead>
                                                <tr class="alert-info">
                                                    <td style="text-align:center">Sr No.</td>
                                                    <td style="text-align:center">Start Date</td>
                                                    <td style="text-align:center">End Date</td>
                                                    <td style="text-align:center">Twin Cabin Price</td>
                                                    <td style="text-align:center" width="50px;">Delete</td>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                
                                            </tbody>
                                        </table>
                                        <label style="color: orangered" name="CabOcnMsg" id="CabOcnMsg"></label>
                                       <br />
                                    </div>
                                    <div class="col-sm-1">
                                        <button class="btn btn-primary nextBtn hidden" id="AddRowOcean" type="button">Add Row</button>
                                    </div>
                                   
								</fieldset>

                                <fieldset id="BalconyDiv" class="hidden">
                                    <legend>Balcony</legend>
                                    <div class="col-sm-7 table-responsive">
                                        <table id="tbl-Bal" class="table table-bordered">
                                            <thead>
                                                <tr class="alert-info">
                                                    <td style="text-align:center">Sr No.</td>
                                                    <td style="text-align:center">Start Date</td>
                                                    <td style="text-align:center">End Date</td>
                                                    <td style="text-align:center">Twin Cabin Price</td>
                                                    <td style="text-align:center" width="50px;">Delete</td>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                
                                            </tbody>
                                        </table>
                                        <label style="color: orangered" name="CabBalMsg" id="CabBalMsg"></label>
                                       <br />
                                    </div>
                                    <div class="col-sm-1">
                                        <button class="btn btn-primary nextBtn hidden" id="AddRowBal" type="button">Add Row</button>
                                    </div>
                                    
								</fieldset>

                                <fieldset id="SuiteDiv" class="hidden">
                                    <legend>Suite</legend>
                                    <div class="col-sm-7 table-responsive">
                                        <table id="tbl-Sui" class="table table-bordered">
                                            <thead>
                                                <tr class="alert-info">
                                                    <td style="text-align:center">Sr No.</td>
                                                    <td style="text-align:center">Start Date</td>
                                                    <td style="text-align:center">End Date</td>
                                                    <td style="text-align:center">Twin Cabin Price</td>
                                                    <td style="text-align:center" width="50px;">Delete</td>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                
                                            </tbody>
                                        </table>
                                        <label style="color: orangered" name="CabSuiMsg" id="CabSuiMsg"></label>
                                       <br />
                                    </div>
                                    <div class="col-sm-1">
                                        <button class="btn btn-primary nextBtn hidden" id="AddRowSui" type="button">Add Row</button>
                                    </div>
                                   
								</fieldset>--%>

							</div>
							
                             <label style="color: orangered" name="Cruise" id="tab2"></label>
                            <br />
							<button class="btn btn-primary nextBtn pull-right" id="btntab2"  type="button">Next</button>
						</div>
					</div>
					
					<div class="panel panel-primary setup-content" id="step-3">
						<div class="panel-heading">
							 <h3 class="panel-title">Itenary Details</h3>
						</div>
						<div class="panel-body">
                            <div class="form-group">
                                <fieldset>
                                    <legend>Day wise detail</legend>
                                    <div class="col-sm-11 table-responsive">
                                        <table id="tbl-Iten" class="table table-bordered">
                                            <thead>
                                                <tr class="alert-info">
                                                    <td style="text-align:center">Day</td>
                                                    <td style="text-align:center">Detail</td>
                                                    <td style="text-align:center">Arrival Time</td>
                                                    <td style="text-align:center">Departure Time</td>
                                                    <td style="text-align:center" width="50px;">Delete</td>
                                                    <td style="display:none;"></td>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                
                                            </tbody>
                                        </table>
                                        <label style="color: orangered" name="ItenMsg" id="ItenMsg"></label>
                                       <br />
                                    </div>
                                    <div class="col-sm-1">
                                        <button class="btn btn-primary nextBtn" id="AddRowIten" type="button">Add Row</button>
                                    </div>
								</fieldset>
                            </div>							 
                             <label style="color: orangered" name="TrenMessage" id="tab3"></label>
                            <br />
							<button class="btn btn-primary nextBtn pull-right" id ="btnTab3" type="button">Next</button>
						</div>
					</div>
					
					<div class="panel panel-primary setup-content" id="step-4">
						<div class="panel-heading">
							 <h3 class="panel-title">On Board Activities</h3>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<fieldset>
                                    <legend>Entertainment</legend>
                                    <div class="col-sm-12" id="Entertainment">
                                        
					                </div>
								</fieldset>
                                <br />
                                <fieldset>
                                    <legend>Kids Entertainment</legend>
                                    <div class="col-sm-12" id="Kids">
                                        
					                </div>
								</fieldset>
                                <br />
                                <fieldset>
                                    <legend>Lifestyle</legend>
                                    <div class="col-sm-12" id="life">
					                </div>
								</fieldset>

							</div>
                             <label style="color: orangered" name="TrenMessage" id="tab4"></label>
                            <br />
							<button class="btn btn-primary nextBtn pull-right" type="button" id="btnTab4">Next</button>
						</div>
					</div>

                    <div class="panel panel-primary setup-content" id="step-5">
						<div class="panel-heading">
							 <h3 class="panel-title">Cabins</h3>
						</div>
                        <div class="panel-body">
                            <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <fieldset>
                                    <legend>Interior</legend>
                                    <div class="col-sm-12">
                                        <label>Detail Description</label>
                                        <textarea class="inc-text" runat="server" id="intdetail" placeholder="Interior" style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"></textarea>
                                    </div>
								</fieldset>
                                </div>
                                
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <fieldset>
                                    <legend>Oceanview</legend>
                                    <div class="col-sm-12">
                                        <label>Detail Description</label>
                                        <textarea class="inc-text" runat="server" id="oceanviewdetails" placeholder="Oceanview" style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"></textarea>
                                    </div>
								</fieldset>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <fieldset>
                                    <legend>Balcony</legend>
                                    <div class="col-sm-12">
                                        <label>Detail Description</label>
                                        <textarea class="inc-text" runat="server" id="balconydetail" placeholder="Balcony" style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"></textarea>
                                    </div>
								</fieldset>
                                </div>
                                
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <fieldset>
                                    <legend>Suites</legend>
                                    <div class="col-sm-12">
                                        <label>Detail Description</label>
                                        <textarea class="inc-text" runat="server" id="suitesdetail" placeholder="Suites" style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"></textarea>
                                    </div>
								</fieldset>
                                </div>
                            </div>
                        </div>
                        <label style="color: orangered" name="TrenMessage" id="tab5"></label>
                        <br />
						<button class="btn btn-primary nextBtn pull-right" id="btnTab5" type="button">Next</button>
                        </div>
					</div>

                    <div class="panel panel-primary setup-content" id="step-6">
						<div class="panel-heading">
							 <h3 class="panel-title">Ship General Info</h3>
						</div>
						<div class="panel-body">
                            <div class="row">
                                <div class="col-sm-4">
						            <div class="form-group">
							            <label for="Gross--ton">Gross tonnage</label>
							            <input type="text" class="form-control" id="Gross-ton" placeholder="Enter details">
						            </div>
					            </div>
					            <div class="col-sm-4">
							            <label for="no-pass">Number of passengers</label>
							            <input type="number" class="form-control" id="passengers" placeholder="Enter No.of Passengers">
					            </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
							            <label for="noNights">Crew members</label>
							            <input type="text" class="form-control" id="Crew" placeholder="Enter No.of Crew Members">
                                     </div>
					            </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-4">
						             <div class="form-group">
							            <label for="noNights">Number of Staterooms</label>
							            <input type="text" class="form-control" id="stateRoom" placeholder="Enter No.of Staterooms">
                                     </div>
					            </div>
                                <div class="col-sm-4">
									<div class="form-group">
							            <label for="noNights">Length</label>
							            <input type="text" class="form-control" id="length" placeholder="Enter Length">
                                     </div>
								</div>
								<div class="col-sm-4">
									<div class="form-group">
							            <label for="noNights">Decks</label>
							            <input type="text" class="form-control" id="decks" placeholder="Enter No.of Decks">
                                     </div>
								</div>
                            </div>
                            <div class="row">
						        <div class="col-sm-4">
									<div class="form-group">
							            <label for="noNights">Average Speed</label>
							            <input type="text" class="form-control" id="avgSpeed" placeholder="Enter Average Speed">
                                     </div>
								</div>
                                <div class="col-sm-4">
									<div class="form-group">
							            <label for="noNights">Width</label>
							            <input type="text" class="form-control" id="width" placeholder="Enter Width">
                                     </div>
								</div>
					        </div>
                            <label style="color: orangered" name="CruiseDetailMsg" id="CruiseDetailMsg"></label>
                            <br />
                            <button class="btn btn-success pull-right" type="submit" id="btnfinish">Finish!</button>
                            <button class="btn btn-success pull-right" type="submit" id="btnUpdate">Update!</button>
						</div>
					</div>

                    <hr>
			        <div class="row">
				        <div class="col-sm-12">
					        <table id="tblCruiseMaster" class="table table-bordered table-striped">
							
					        </table>
				        </div>
			        </div>
				</form>
			</div>
		</div>	
	</div>	
       
         </section>

      <div class="modal fade" id="deleteCruise" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		    <span aria-hidden="true">&times;</span>
         </button>
          <h4 class="modal-title">Delete Cruise</h4>
        </div>
        <div class="modal-body">
       Are You Sure you want to delete   <span id="CruiseName"></span>
            
        </div>
        <div class="modal-footer">
             <button type="button" id="btnConfirm" class="btn btn-info" data-dismiss="modal">Confirm</button>
           
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
    </div>

    <div class="modal fade" id="UpdateTrip" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-label="Close">
										  <span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">Update Tour</h4>
        </div>
        <div class="modal-body">
      Do you want to update itenary detail?
            
        </div>
        <div class="modal-footer">
             <button type="button" id="btnTour" class="btn btn-info" data-dismiss="modal">Yes</button>
           
          <button type="button" class="btn btn-default" id="btnCancel" data-dismiss="modal">No</button>
        </div>
      </div>
      
    </div>
    </div>

    <div class="modal fade" id="Image" role="dialog">
        <div class="modal-dialog">
    
        <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
									                <span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Cruise Images</h4>
                </div>
                <div class="modal-body">
                   <table id="tableImages" class="table table-bordered table-striped" ></table>
            
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default"  data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

      <div class="modal fade" id="deleteImage" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-label="Close">
										  <span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">Tour Images</h4>
        </div>
        <div class="modal-body">
   Are you sure you want to delete the image?
            
        </div>
        <div class="modal-footer">
           
            <button type="button" class="btn btn-default" id="confirmImage"  data-dismiss="modal">Confirm</button>
          <button type="button" class="btn btn-default"  data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
    </div>

     <div class="modal fade" id="CabinData" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content" style="width:900px">
        <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-label="Close">
										  <span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">Cabin Dates and Other detail</h4>
        </div>
        <div class="modal-body">
     <div class="row">
                                     
                                <div class="col-sm-12">
                                 <div class="col-sm-3">Select Dates </div> <div class="col-sm-4"><input type="text" id="inpFromDate" placeholder="Start Date" class=" daterange-picker" /></div><div class="col-sm-4"><input type="text" id="inpToDate" placeholder="End Date" class="daterange-picker" /></div>
                                   
                                </div>
                                    </div>
            <div class="row">
                <div class="col-sm-12">
                <div class="col-sm-3">Enter Price</div>
               <div class="col-sm-3"> <input type="text" id="txtMainPrice" onkeypress="return isNumber();" /></div>
                    </div>
            </div>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <%--<div class="col-sm-3"><input type="checkbox" id="allCheck" name="cabin" value="All" />All </div>--%>
                                        <div class="col-sm-3">
                                            <input type="checkbox" name="cabin" id="InteriorCheck" class="allCabin" value="1" />Interior </div>
                                         <div class="col-sm-3">
                                        <input type="text" name="cabin" id="intPrice" class="allCabin" onkeypress="return isNumber();"/> </div>
                                         <div class="col-sm-3">
						                
						                 
						                  <input type="file" id="Int-image">
						                
						                
					                </div>
                                    </div>
                                    <div class="col-sm-12">
                                        <div class="col-sm-3">
                                            <input type="checkbox" id="OceanCheck" class="allCabin" name="cabin" value="2" />OceanView </div>
                                        <div class="col-sm-3">
                                        <input type="text" name="cabin" id="OceanPrice" class="allCabin" onkeypress="return isNumber();" /> </div>

                                         <div class="col-sm-3">
						             
						                  <input type="file" id="Ocn-image">
						                 
						                
					                </div>
                                        </div>
                                        <div class="col-sm-12">
                                    <div class="col-sm-3"><input type="checkbox" id="balconyCheck" name="cabin" class="allCabin" value="3"/>Balcony </div>
                                               <div class="col-sm-3">
                                        <input type="text" name="cabin" id="BalPrice" class="allCabin" onkeypress="return isNumber();" /> </div>
                                            <div class="col-sm-3">
						              
						                  <input type="file" id="Bal-image">
						                
						                </div>
					                </div>
                                           
                                <div class="col-sm-12">
                                    <div class="col-sm-3"><input type="checkbox" id="SuiteCheck" name="cabin" class="allCabin" value="4" />Suite </div> 
         <div class="col-sm-3">
                                        <input type="text" name="cabin" id="SuitePrice" class="allCabin" onkeypress="return isNumber();" /> </div>
                              
    <div class="col-sm-3">
						               
						                  <input type="file" id="Sui-image">
						               
						              
					                </div>
                                    </div>
                                     </div>
         
           <div class="row">
                 <div class="col-sm-4"><span id="errmsgfordates" style="color:red"></span></div> 
            </div>
            
     </div>
        <div class="modal-footer">
             <button type="button" id="btnaddTempData" class="btn btn-info"> Add Dates</button>
           <button type="button" id="btnUpdateTemp" class="btn btn-info"> Update Dates</button>
          <button type="button" class="btn btn-default" id="btnCancelTempData" data-dismiss="modal">Cancel</button>
        </div>
  </div>
        </div>
       
 

    <script>
        $(function () {
            $('.overview-text').wysihtml5()
            $('.inc-text').wysihtml5()
            $('.day-text').wysihtml5()
        })

        $(document).ready(function () {


        });
</script>
</asp:Content>