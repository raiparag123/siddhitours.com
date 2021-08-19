/*** Contains following js merged ************
******* 1. COLVIS
******* 2. FIXED HEADER
******* 3. DATATABLES BOOTSTRAP
******* 4. FIXED COLUMNS
************************************************/
/*! ColVis 1.1.0
 * ©2010-2014 SpryMedia Ltd - datatables.net/license
 */

/**
 * @summary     ColVis
 * @description Controls for column visibility in DataTables
 * @version     1.1.0
 * @file        dataTables.colReorder.js
 * @author      SpryMedia Ltd (www.sprymedia.co.uk)
 * @contact     www.sprymedia.co.uk/contact
 * @copyright   Copyright 2010-2014 SpryMedia Ltd.
 *
 * This source file is free software, available under the following license:
 *   MIT license - http://datatables.net/license/mit
 *
 * This source file is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
 * or FITNESS FOR A PARTICULAR PURPOSE. See the license files for details.
 *
 * For details please refer to: http://www.datatables.net
 */

(function(window, document, undefined) {


var factory = function( $, DataTable ) {
"use strict";

/**
 * ColVis provides column visibility control for DataTables
 *
 * @class ColVis
 * @constructor
 * @param {object} DataTables settings object. With DataTables 1.10 this can
 *   also be and API instance, table node, jQuery collection or jQuery selector.
 * @param {object} ColVis configuration options
 */
var ColVis = function( oDTSettings, oInit )
{
	/* Santiy check that we are a new instance */
	if ( !this.CLASS || this.CLASS != "ColVis" )
	{
		alert( "Warning: ColVis must be initialised with the keyword 'new'" );
	}

	if ( typeof oInit == 'undefined' )
	{
		oInit = {};
	}

	if ( $.fn.dataTable.camelToHungarian ) {
		$.fn.dataTable.camelToHungarian( ColVis.defaults, oInit );
	}


	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Public class variables
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

	/**
	 * @namespace Settings object which contains customisable information for
	 *     ColVis instance. Augmented by ColVis.defaults
	 */
	this.s = {
		/**
		 * DataTables settings object
		 *  @property dt
		 *  @type     Object
		 *  @default  null
		 */
		"dt": null,

		/**
		 * Customisation object
		 *  @property oInit
		 *  @type     Object
		 *  @default  passed in
		 */
		"oInit": oInit,

		/**
		 * Flag to say if the collection is hidden
		 *  @property hidden
		 *  @type     boolean
		 *  @default  true
		 */
		"hidden": true,

		/**
		 * Store the original visibility settings so they could be restored
		 *  @property abOriginal
		 *  @type     Array
		 *  @default  []
		 */
		"abOriginal": []
	};


	/**
	 * @namespace Common and useful DOM elements for the class instance
	 */
	this.dom = {
		/**
		 * Wrapper for the button - given back to DataTables as the node to insert
		 *  @property wrapper
		 *  @type     Node
		 *  @default  null
		 */
		"wrapper": null,

		/**
		 * Activation button
		 *  @property button
		 *  @type     Node
		 *  @default  null
		 */
		"button": null,

		/**
		 * Collection list node
		 *  @property collection
		 *  @type     Node
		 *  @default  null
		 */
		"collection": null,

		/**
		 * Background node used for shading the display and event capturing
		 *  @property background
		 *  @type     Node
		 *  @default  null
		 */
		"background": null,

		/**
		 * Element to position over the activation button to catch mouse events when using mouseover
		 *  @property catcher
		 *  @type     Node
		 *  @default  null
		 */
		"catcher": null,

		/**
		 * List of button elements
		 *  @property buttons
		 *  @type     Array
		 *  @default  []
		 */
		"buttons": [],

		/**
		 * List of group button elements
		 *  @property groupButtons
		 *  @type     Array
		 *  @default  []
		 */
		"groupButtons": [],

		/**
		 * Restore button
		 *  @property restore
		 *  @type     Node
		 *  @default  null
		 */
		"restore": null
	};

	/* Store global reference */
	ColVis.aInstances.push( this );

	/* Constructor logic */
	this.s.dt = $.fn.dataTable.Api ?
		new $.fn.dataTable.Api( oDTSettings ).settings()[0] :
		oDTSettings;

	this._fnConstruct( oInit );
	return this;
};



ColVis.prototype = {
	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Public methods
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

	/**
	 * Get the ColVis instance's control button so it can be injected into the
	 * DOM
	 *  @method  button
	 *  @returns {node} ColVis button
	 */
	button: function ()
	{
		return this.dom.wrapper;
	},

	/**
	 * Alias of `rebuild` for backwards compatibility
	 *  @method  fnRebuild
	 */
	"fnRebuild": function ()
	{
		this.rebuild();
	},

	/**
	 * Rebuild the list of buttons for this instance (i.e. if there is a column
	 * header update)
	 *  @method  fnRebuild
	 */
	rebuild: function ()
	{
		/* Remove the old buttons */
		for ( var i=this.dom.buttons.length-1 ; i>=0 ; i-- ) {
			this.dom.collection.removeChild( this.dom.buttons[i] );
		}
		this.dom.buttons.splice( 0, this.dom.buttons.length );

		if ( this.dom.restore ) {
			this.dom.restore.parentNode( this.dom.restore );
		}

		/* Re-add them (this is not the optimal way of doing this, it is fast and effective) */
		this._fnAddGroups();
		this._fnAddButtons();

		/* Update the checkboxes */
		this._fnDrawCallback();
	},


	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Private methods (they are of course public in JS, but recommended as private)
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

	/**
	 * Constructor logic
	 *  @method  _fnConstruct
	 *  @returns void
	 *  @private
	 */
	"_fnConstruct": function ( init )
	{
		this._fnApplyCustomisation( init );

		var that = this;
		var i, iLen;
		this.dom.wrapper = document.createElement('div');
		this.dom.wrapper.className = "ColVis";

		this.dom.button = $( '<button />', {
				'class': !this.s.dt.bJUI ?
					"ColVis_Button ColVis_MasterButton" :
					"ColVis_Button ColVis_MasterButton ui-button ui-state-default"
			} )
			.append( '<span>'+this.s.buttonText+'</span>' )
			.bind( this.s.activate=="mouseover" ? "mouseover" : "click", function (e) {
				e.preventDefault();
				that._fnCollectionShow();
			} )
			.appendTo( this.dom.wrapper )[0];

		this.dom.catcher = this._fnDomCatcher();
		this.dom.collection = this._fnDomCollection();
		this.dom.background = this._fnDomBackground();

		this._fnAddGroups();
		this._fnAddButtons();

		/* Store the original visibility information */
		for ( i=0, iLen=this.s.dt.aoColumns.length ; i<iLen ; i++ )
		{
			this.s.abOriginal.push( this.s.dt.aoColumns[i].bVisible );
		}

		/* Update on each draw */
		this.s.dt.aoDrawCallback.push( {
			"fn": function () {
				that._fnDrawCallback.call( that );
			},
			"sName": "ColVis"
		} );

		/* If columns are reordered, then we need to update our exclude list and
		 * rebuild the displayed list
		 */
		$(this.s.dt.oInstance).bind( 'column-reorder', function ( e, oSettings, oReorder ) {
			for ( i=0, iLen=that.s.aiExclude.length ; i<iLen ; i++ ) {
				that.s.aiExclude[i] = oReorder.aiInvertMapping[ that.s.aiExclude[i] ];
			}

			var mStore = that.s.abOriginal.splice( oReorder.iFrom, 1 )[0];
			that.s.abOriginal.splice( oReorder.iTo, 0, mStore );

			that.fnRebuild();
		} );

		// Set the initial state
		this._fnDrawCallback();
	},


	/**
	 * Apply any customisation to the settings from the DataTables initialisation
	 *  @method  _fnApplyCustomisation
	 *  @returns void
	 *  @private
	 */
	"_fnApplyCustomisation": function ( init )
	{
		$.extend( true, this.s, ColVis.defaults, init );

		// Slightly messy overlap for the camelCase notation
		if ( ! this.s.showAll && this.s.bShowAll ) {
			this.s.showAll = this.s.sShowAll;
		}

		if ( ! this.s.restore && this.s.bRestore ) {
			this.s.restore = this.s.sRestore;
		}

		// CamelCase to Hungarian for the column groups
		var groups = this.s.groups;
		var hungarianGroups = this.s.aoGroups;
		if ( groups ) {
			for ( var i=0, ien=groups.length ; i<ien ; i++ ) {
				if ( groups[i].title ) {
					hungarianGroups[i].sTitle = groups[i].title;
				}
				if ( groups[i].columns ) {
					hungarianGroups[i].aiColumns = groups[i].columns;
				}
			}
		}
	},


	/**
	 * On each table draw, check the visibility checkboxes as needed. This allows any process to
	 * update the table's column visibility and ColVis will still be accurate.
	 *  @method  _fnDrawCallback
	 *  @returns void
	 *  @private
	 */
	"_fnDrawCallback": function ()
	{
		var columns = this.s.dt.aoColumns;
		var buttons = this.dom.buttons;
		var groups = this.s.aoGroups;
		var button;

		for ( var i=0, ien=buttons.length ; i<ien ; i++ ) {
			button = buttons[i];

			if ( button.__columnIdx !== undefined ) {
				$('input', button).prop( 'checked', columns[ button.__columnIdx ].bVisible );
			}
		}

		var allVisible = function ( columnIndeces ) {
			for ( var k=0, kLen=columnIndeces.length ; k<kLen ; k++ )
			{
				if (  columns[columnIndeces[k]].bVisible === false ) { return false; }
			}
			return true;
		};
		var allHidden = function ( columnIndeces ) {
			for ( var m=0 , mLen=columnIndeces.length ; m<mLen ; m++ )
			{
				if ( columns[columnIndeces[m]].bVisible === true ) { return false; }
			}
			return true;
		};

		for ( var j=0, jLen=groups.length ; j<jLen ; j++ )
		{
			if ( allVisible(groups[j].aiColumns) )
			{
				$('input', this.dom.groupButtons[j]).prop('checked', true);
				$('input', this.dom.groupButtons[j]).prop('indeterminate', false);
			}
			else if ( allHidden(groups[j].aiColumns) )
			{
				$('input', this.dom.groupButtons[j]).prop('checked', false);
				$('input', this.dom.groupButtons[j]).prop('indeterminate', false);
			}
			else
			{
				$('input', this.dom.groupButtons[j]).prop('indeterminate', true);
			}
		}

		//Sharad edit for repainting fixed header
		$(this.s.dt.nTable).trigger( 'column-visibility');

	},


	/**
	 * Loop through the groups (provided in the settings) and create a button for each.
	 *  @method  _fnAddgroups
	 *  @returns void
	 *  @private
	 */
	"_fnAddGroups": function ()
	{
		var nButton;

		if ( typeof this.s.aoGroups != 'undefined' )
		{
			for ( var i=0, iLen=this.s.aoGroups.length ; i<iLen ; i++ )
			{
				nButton = this._fnDomGroupButton( i );
				this.dom.groupButtons.push( nButton );
				this.dom.buttons.push( nButton );
				this.dom.collection.appendChild( nButton );
			}
		}
	},


	/**
	 * Loop through the columns in the table and as a new button for each one.
	 *  @method  _fnAddButtons
	 *  @returns void
	 *  @private
	 */
	"_fnAddButtons": function ()
	{
		var
			nButton,
			columns = this.s.dt.aoColumns;

		if ( $.inArray( 'all', this.s.aiExclude ) === -1 ) {
			for ( var i=0, iLen=columns.length ; i<iLen ; i++ )
			{
				if ( $.inArray( i, this.s.aiExclude ) === -1 )
				{
					nButton = this._fnDomColumnButton( i );
					nButton.__columnIdx = i;
					this.dom.buttons.push( nButton );
				}
			}
		}

		if ( this.s.order === 'alpha' ) {
			this.dom.buttons.sort( function ( a, b ) {
				var titleA = columns[ a.__columnIdx ].sTitle;
				var titleB = columns[ b.__columnIdx ].sTitle;

				return titleA === titleB ?
					0 :
					titleA < titleB ?
						-1 :
						1;
			} );
		}

		if ( this.s.restore )
		{
			nButton = this._fnDomRestoreButton();
			nButton.className += " ColVis_Restore";
			this.dom.buttons.push( nButton );
		}

		if ( this.s.showAll )
		{
			nButton = this._fnDomShowAllButton();
			nButton.className += " ColVis_ShowAll";
			this.dom.buttons.push( nButton );
		}

		$(this.dom.collection).append( this.dom.buttons );
	},


	/**
	 * Create a button which allows a "restore" action
	 *  @method  _fnDomRestoreButton
	 *  @returns {Node} Created button
	 *  @private
	 */
	"_fnDomRestoreButton": function ()
	{
		var
			that = this,
			dt = this.s.dt;

		return $(
				'<li class="ColVis_Special '+(dt.bJUI ? 'ui-button ui-state-default' : '')+'">'+
					this.s.restore+
				'</li>'
			)
			.click( function (e) {
				for ( var i=0, iLen=that.s.abOriginal.length ; i<iLen ; i++ )
				{
					that.s.dt.oInstance.fnSetColumnVis( i, that.s.abOriginal[i], false );
				}
				that._fnAdjustOpenRows();
				that.s.dt.oInstance.fnAdjustColumnSizing( false );
				that.s.dt.oInstance.fnDraw( false );
			} )[0];
	},


	/**
	 * Create a button which allows a "show all" action
	 *  @method  _fnDomShowAllButton
	 *  @returns {Node} Created button
	 *  @private
	 */
	"_fnDomShowAllButton": function ()
	{
		var
			that = this,
			dt = this.s.dt;

		return $(
				'<li class="ColVis_Special '+(dt.bJUI ? 'ui-button ui-state-default' : '')+'">'+
					this.s.showAll+
				'</li>'
			)
			.click( function (e) {
				for ( var i=0, iLen=that.s.abOriginal.length ; i<iLen ; i++ )
				{
					if (that.s.aiExclude.indexOf(i) === -1)
					{
						that.s.dt.oInstance.fnSetColumnVis( i, true, false );
					}
				}
				that._fnAdjustOpenRows();
				that.s.dt.oInstance.fnAdjustColumnSizing( false );
				that.s.dt.oInstance.fnDraw( false );
			} )[0];
	},


	/**
	 * Create the DOM for a show / hide group button
	 *  @method  _fnDomGroupButton
	 *  @param {int} i Group in question, order based on that provided in settings
	 *  @returns {Node} Created button
	 *  @private
	 */
	"_fnDomGroupButton": function ( i )
	{
		var
			that = this,
			dt = this.s.dt,
			oGroup = this.s.aoGroups[i];

		return $(
				'<li class="ColVis_Special '+(dt.bJUI ? 'ui-button ui-state-default' : '')+'">'+
					'<label>'+
						'<input type="checkbox" />'+
						'<span>'+oGroup.sTitle+'</span>'+
					'</label>'+
				'</li>'
			)
			.click( function (e) {
				var showHide = !$('input', this).is(":checked");
				if (  e.target.nodeName.toLowerCase() !== "li" )
				{
					showHide = ! showHide;
				}

				for ( var j=0 ; j < oGroup.aiColumns.length ; j++ )
				{
					that.s.dt.oInstance.fnSetColumnVis( oGroup.aiColumns[j], showHide );
				}
			} )[0];
	},


	/**
	 * Create the DOM for a show / hide button
	 *  @method  _fnDomColumnButton
	 *  @param {int} i Column in question
	 *  @returns {Node} Created button
	 *  @private
	 */
	"_fnDomColumnButton": function ( i )
	{
		var
			that = this,
			column = this.s.dt.aoColumns[i],
			dt = this.s.dt;

		var title = this.s.fnLabel===null ?
			column.sTitle :
			this.s.fnLabel( i, column.sTitle, column.nTh );

		return $(
				'<li '+(dt.bJUI ? 'class="ui-button ui-state-default"' : '')+'>'+
					'<label>'+
						'<input type="checkbox" />'+
						'<span>'+title+'</span>'+
					'</label>'+
				'</li>'
			)
			.click( function (e) {
				var showHide = !$('input', this).is(":checked");
				if (  e.target.nodeName.toLowerCase() !== "li" )
				{
					showHide = ! showHide;
				}

				/* Need to consider the case where the initialiser created more than one table - change the
				 * API index that DataTables is using
				 */
				var oldIndex = $.fn.dataTableExt.iApiIndex;
				$.fn.dataTableExt.iApiIndex = that._fnDataTablesApiIndex.call(that);

				// Optimisation for server-side processing when scrolling - don't do a full redraw
				if ( dt.oFeatures.bServerSide )
				{
					that.s.dt.oInstance.fnSetColumnVis( i, showHide, false );
					that.s.dt.oInstance.fnAdjustColumnSizing( false );
					if (dt.oScroll.sX !== "" || dt.oScroll.sY !== "" )
					{
						that.s.dt.oInstance.oApi._fnScrollDraw( that.s.dt );
					}
					that._fnDrawCallback();
				}
				else
				{
					that.s.dt.oInstance.fnSetColumnVis( i, showHide );
				}

				$.fn.dataTableExt.iApiIndex = oldIndex; /* Restore */

				if ( that.s.fnStateChange !== null )
				{
					that.s.fnStateChange.call( that, i, showHide );
				}
			} )[0];
	},


	/**
	 * Get the position in the DataTables instance array of the table for this
	 * instance of ColVis
	 *  @method  _fnDataTablesApiIndex
	 *  @returns {int} Index
	 *  @private
	 */
	"_fnDataTablesApiIndex": function ()
	{
		for ( var i=0, iLen=this.s.dt.oInstance.length ; i<iLen ; i++ )
		{
			if ( this.s.dt.oInstance[i] == this.s.dt.nTable )
			{
				return i;
			}
		}
		return 0;
	},


	/**
	 * Create the element used to contain list the columns (it is shown and
	 * hidden as needed)
	 *  @method  _fnDomCollection
	 *  @returns {Node} div container for the collection
	 *  @private
	 */
	"_fnDomCollection": function ()
	{
		return $('<ul />', {
				'class': !this.s.dt.bJUI ?
					"ColVis_collection" :
					"ColVis_collection ui-buttonset ui-buttonset-multi"
			} )
		.css( {
			'display': 'none',
			'opacity': 0,
			'position': ! this.s.bCssPosition ?
				'absolute' :
				''
		} )[0];
	},


	/**
	 * An element to be placed on top of the activate button to catch events
	 *  @method  _fnDomCatcher
	 *  @returns {Node} div container for the collection
	 *  @private
	 */
	"_fnDomCatcher": function ()
	{
		var
			that = this,
			nCatcher = document.createElement('div');
		nCatcher.className = "ColVis_catcher";

		$(nCatcher).click( function () {
			that._fnCollectionHide.call( that, null, null );
		} );

		return nCatcher;
	},


	/**
	 * Create the element used to shade the background, and capture hide events (it is shown and
	 * hidden as needed)
	 *  @method  _fnDomBackground
	 *  @returns {Node} div container for the background
	 *  @private
	 */
	"_fnDomBackground": function ()
	{
		var that = this;

		var background = $('<div></div>')
			.addClass( 'ColVis_collectionBackground' )
			.css( 'opacity', 0 )
			.click( function () {
				that._fnCollectionHide.call( that, null, null );
			} );

		/* When considering a mouse over action for the activation, we also consider a mouse out
		 * which is the same as a mouse over the background - without all the messing around of
		 * bubbling events. Use the catcher element to avoid messing around with bubbling
		 */
		if ( this.s.activate == "mouseover" )
		{
			background.mouseover( function () {
				that.s.overcollection = false;
				that._fnCollectionHide.call( that, null, null );
			} );
		}

		return background[0];
	},


	/**
	 * Show the show / hide list and the background
	 *  @method  _fnCollectionShow
	 *  @returns void
	 *  @private
	 */
	"_fnCollectionShow": function ()
	{
		var that = this, i, iLen, iLeft;
		var oPos = $(this.dom.button).offset();
		var nHidden = this.dom.collection;
		var nBackground = this.dom.background;
		var iDivX = parseInt(oPos.left, 10);
		var iDivY = parseInt(oPos.top + $(this.dom.button).outerHeight(), 10);

		if ( ! this.s.bCssPosition )
		{
			nHidden.style.top = iDivY+"px";
			nHidden.style.left = iDivX+"px";
		}

		$(nHidden).css( {
			'display': 'block',
			'opacity': 0
		} );

		nBackground.style.bottom ='0px';
		nBackground.style.right = '0px';

		var oStyle = this.dom.catcher.style;
		oStyle.height = $(this.dom.button).outerHeight()+"px";
		oStyle.width = $(this.dom.button).outerWidth()+"px";
		oStyle.top = oPos.top+"px";
		oStyle.left = iDivX+"px";

		document.body.appendChild( nBackground );
		document.body.appendChild( nHidden );
		document.body.appendChild( this.dom.catcher );

		/* This results in a very small delay for the end user but it allows the animation to be
		 * much smoother. If you don't want the animation, then the setTimeout can be removed
		 */
		$(nHidden).animate({"opacity": 1}, that.s.iOverlayFade);
		$(nBackground).animate({"opacity": 0.1}, that.s.iOverlayFade, 'linear', function () {
			/* In IE6 if you set the checked attribute of a hidden checkbox, then this is not visually
			 * reflected. As such, we need to do it here, once it is visible. Unbelievable.
			 */
			if ( $.browser && $.browser.msie && $.browser.version == "6.0" )
			{
				that._fnDrawCallback();
			}
		});

		/* Visual corrections to try and keep the collection visible */
		if ( !this.s.bCssPosition )
		{
			iLeft = ( this.s.sAlign=="left" ) ?
				iDivX :
				iDivX - $(nHidden).outerWidth() + $(this.dom.button).outerWidth();

			nHidden.style.left = iLeft+"px";

			var iDivWidth = $(nHidden).outerWidth();
			var iDivHeight = $(nHidden).outerHeight();
			var iDocWidth = $(document).width();

			if ( iLeft + iDivWidth > iDocWidth )
			{
				nHidden.style.left = (iDocWidth-iDivWidth)+"px";
			}
		}

		this.s.hidden = false;
	},


	/**
	 * Hide the show / hide list and the background
	 *  @method  _fnCollectionHide
	 *  @returns void
	 *  @private
	 */
	"_fnCollectionHide": function (  )
	{
		var that = this;

		if ( !this.s.hidden && this.dom.collection !== null )
		{
			this.s.hidden = true;

			$(this.dom.collection).animate({"opacity": 0}, that.s.iOverlayFade, function (e) {
				this.style.display = "none";
			} );

			$(this.dom.background).animate({"opacity": 0}, that.s.iOverlayFade, function (e) {
				document.body.removeChild( that.dom.background );
				document.body.removeChild( that.dom.catcher );
			} );
		}
	},


	/**
	 * Alter the colspan on any fnOpen rows
	 */
	"_fnAdjustOpenRows": function ()
	{
		var aoOpen = this.s.dt.aoOpenRows;
		var iVisible = this.s.dt.oApi._fnVisbleColumns( this.s.dt );

		for ( var i=0, iLen=aoOpen.length ; i<iLen ; i++ ) {
			aoOpen[i].nTr.getElementsByTagName('td')[0].colSpan = iVisible;
		}
	}
};





/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Static object methods
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/**
 * Rebuild the collection for a given table, or all tables if no parameter given
 *  @method  ColVis.fnRebuild
 *  @static
 *  @param   object oTable DataTable instance to consider - optional
 *  @returns void
 */
ColVis.fnRebuild = function ( oTable )
{
	var nTable = null;
	if ( typeof oTable != 'undefined' )
	{
		nTable = oTable.fnSettings().nTable;
	}

	for ( var i=0, iLen=ColVis.aInstances.length ; i<iLen ; i++ )
	{
		if ( typeof oTable == 'undefined' || nTable == ColVis.aInstances[i].s.dt.nTable )
		{
			ColVis.aInstances[i].fnRebuild();
		}
	}
};


ColVis.defaults = {
	/**
	 * Mode of activation. Can be 'click' or 'mouseover'
	 *  @property activate
	 *  @type     string
	 *  @default  click
	 */
	active: 'click',

	/**
	 * Text used for the button
	 *  @property buttonText
	 *  @type     string
	 *  @default  Show / hide columns
	 */
	buttonText: 'Show / hide columns',

	/**
	 * List of columns (integers) which should be excluded from the list
	 *  @property aiExclude
	 *  @type     array
	 *  @default  []
	 */
	aiExclude: [],

	/**
	 * Show restore button
	 *  @property bRestore
	 *  @type     boolean
	 *  @default  false
	 */
	bRestore: false,

	/**
	 * Restore button text
	 *  @property sRestore
	 *  @type     string
	 *  @default  Restore original
	 */
	sRestore: 'Restore original',

	/**
	 * Show Show-All button
	 *  @property bShowAll
	 *  @type     boolean
	 *  @default  false
	 */
	bShowAll: false,

	/**
	 * Show All button text
	 *  @property sShowAll
	 *  @type     string
	 *  @default  Restore original
	 */
	sShowAll: 'Show All',

	/**
	 * Position of the collection menu when shown - align "left" or "right"
	 *  @property sAlign
	 *  @type     string
	 *  @default  left
	 */
	sAlign: 'left',

	/**
	 * Callback function to tell the user when the state has changed
	 *  @property fnStateChange
	 *  @type     function
	 *  @default  null
	 */
	fnStateChange: null,

	/**
	 * Overlay animation duration in mS
	 *  @property iOverlayFade
	 *  @type     integer|false
	 *  @default  500
	 */
	iOverlayFade: 500,

	/**
	 * Label callback for column names. Takes three parameters: 1. the
	 * column index, 2. the column title detected by DataTables and 3. the
	 * TH node for the column
	 *  @property fnLabel
	 *  @type     function
	 *  @default  null
	 */
	fnLabel: null,

	/**
	 * Indicate if the column list should be positioned by Javascript,
	 * visually below the button or allow CSS to do the positioning
	 *  @property bCssPosition
	 *  @type     boolean
	 *  @default  false
	 */
	bCssPosition: false,

	/**
	 * Group buttons
	 *  @property aoGroups
	 *  @type     array
	 *  @default  []
	 */
	aoGroups: [],

	/**
	 * Button ordering - 'alpha' (alphabetical) or 'column' (table column
	 * order)
	 *  @property order
	 *  @type     string
	 *  @default  column
	 */
	order: 'column'
};



/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Static object properties
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/**
 * Collection of all ColVis instances
 *  @property ColVis.aInstances
 *  @static
 *  @type     Array
 *  @default  []
 */
ColVis.aInstances = [];





/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Constants
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/**
 * Name of this class
 *  @constant CLASS
 *  @type     String
 *  @default  ColVis
 */
ColVis.prototype.CLASS = "ColVis";


/**
 * ColVis version
 *  @constant  VERSION
 *  @type      String
 *  @default   See code
 */
ColVis.VERSION = "1.1.0";
ColVis.prototype.VERSION = ColVis.VERSION;





/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Initialisation
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/*
 * Register a new feature with DataTables
 */
if ( typeof $.fn.dataTable == "function" &&
     typeof $.fn.dataTableExt.fnVersionCheck == "function" &&
     $.fn.dataTableExt.fnVersionCheck('1.7.0') )
{
	$.fn.dataTableExt.aoFeatures.push( {
		"fnInit": function( oDTSettings ) {
			var init = oDTSettings.oInit;
			var colvis = new ColVis( oDTSettings, init.colVis || init.oColVis || {} );
			return colvis.button();
		},
		"cFeature": "C",
		"sFeature": "ColVis"
	} );
}
else
{
	alert( "Warning: ColVis requires DataTables 1.7 or greater - www.datatables.net/download");
}


// Make ColVis accessible from the DataTables instance
$.fn.dataTable.ColVis = ColVis;
$.fn.DataTable.ColVis = ColVis;


return ColVis;
}; // /factory


// Define as an AMD module if possible
if ( typeof define === 'function' && define.amd ) {
	define( 'datatables-colvis', ['jquery', 'datatables'], factory );
}
else if ( jQuery && !jQuery.fn.dataTable.ColVis ) {
	// Otherwise simply initialise as normal, stopping multiple evaluation
	factory( jQuery, jQuery.fn.dataTable );
}


})(window, document);


/* FIXED HEADER JS STARTS FROM HERE */

/*! FixedHeader 2.1.2
 * Â©2010-2014 SpryMedia Ltd - datatables.net/license
 */

/**
 * @summary     FixedHeader
 * @description Fix a table's header or footer, so it is always visible while
 *              Scrolling
 * @version     2.1.2
 * @file        dataTables.fixedHeader.js
 * @author      SpryMedia Ltd (www.sprymedia.co.uk)
 * @contact     www.sprymedia.co.uk/contact
 * @copyright   Copyright 2009-2014 SpryMedia Ltd.
 *
 * This source file is free software, available under the following license:
 *   MIT license - http://datatables.net/license/mit
 *
 * This source file is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
 * or FITNESS FOR A PARTICULAR PURPOSE. See the license files for details.
 *
 * For details please refer to: http://www.datatables.net
 */

/* Global scope for FixedColumns for backwards compatibility - will be removed
 * in future. Not documented in 1.1.x.
 */

/* Global scope for FixedColumns */
var FixedHeader;

(function(window, document, undefined) {


var factory = function( $, DataTable ) {
"use strict";

/*
 * Function: FixedHeader
 * Purpose:  Provide 'fixed' header, footer and columns for a DataTable
 * Returns:  object:FixedHeader - must be called with 'new'
 * Inputs:   mixed:mTable - target table
 *  @param {object} dt DataTables instance or HTML table node. With DataTables
 *    1.10 this can also be a jQuery collection (with just a single table in its
 *    result set), a jQuery selector, DataTables API instance or settings
 *    object.
 *  @param {object} [oInit] initialisation settings, with the following
 *    properties (each optional)
 *    * bool:top -    fix the header (default true)
 *    * bool:bottom - fix the footer (default false)
 *    * int:left -    fix the left column(s) (default 0)
 *    * int:right -   fix the right column(s) (default 0)
 *    * int:zTop -    fixed header zIndex
 *    * int:zBottom - fixed footer zIndex
 *    * int:zLeft -   fixed left zIndex
 *    * int:zRight -  fixed right zIndex
 */
FixedHeader = function ( mTable, oInit ) {
	/* Sanity check - you just know it will happen */
	if ( ! this instanceof FixedHeader )
	{
		alert( "FixedHeader warning: FixedHeader must be initialised with the 'new' keyword." );
		return;
	}

	var that = this;
	var oSettings = {
		"aoCache": [],
		"oSides": {
			"top": true,
			"bottom": false,
			"left": 0,
			"right": 0
		},
		"oZIndexes": {
			"top": 104,
			"bottom": 103,
			"left": 102,
			"right": 101
		},
		"oCloneOnDraw": {
			"top": false,
			"bottom": false,
			"left": true,
			"right": true
		},
		"oMes": {
			"iTableWidth": 0,
			"iTableHeight": 0,
			"iTableLeft": 0,
			"iTableRight": 0, /* note this is left+width, not actually "right" */
			"iTableTop": 0,
			"iTableBottom": 0 /* note this is top+height, not actually "bottom" */
		},
		"oOffset": {
			"top": 0
		},
		"nTable": null,
		"bFooter": false,
		"bInitComplete": false
	};

	/*
	 * Function: fnGetSettings
	 * Purpose:  Get the settings for this object
	 * Returns:  object: - settings object
	 * Inputs:   -
	 */
	this.fnGetSettings = function () {
		return oSettings;
	};

	/*
	 * Function: fnUpdate
	 * Purpose:  Update the positioning and copies of the fixed elements
	 * Returns:  -
	 * Inputs:   -
	 */
	this.fnUpdate = function () {
		this._fnUpdateClones();
		this._fnUpdatePositions();
	};

	/*
	 * Function: fnPosition
	 * Purpose:  Update the positioning of the fixed elements
	 * Returns:  -
	 * Inputs:   -
	 */
	this.fnPosition = function () {
		this._fnUpdatePositions();
	};


	var dt = $.fn.dataTable.Api ?
		new $.fn.dataTable.Api( mTable ).settings()[0] :
		mTable.fnSettings();

	dt._oPluginFixedHeader = this;

	/* Let's do it */
	this.fnInit( dt, oInit );

};


/*
 * Variable: FixedHeader
 * Purpose:  Prototype for FixedHeader
 * Scope:    global
 */
FixedHeader.prototype = {
	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Initialisation
	 */

	/*
	 * Function: fnInit
	 * Purpose:  The "constructor"
	 * Returns:  -
	 * Inputs:   {as FixedHeader function}
	 */
	fnInit: function ( oDtSettings, oInit )
	{
		var s = this.fnGetSettings();
		var that = this;

		/* Record the user definable settings */
		this.fnInitSettings( s, oInit );

		if ( oDtSettings.oScroll.sX !== "" || oDtSettings.oScroll.sY !== "" )
		{
			alert( "FixedHeader 2 is not supported with DataTables' scrolling mode at this time" );
			return;
		}

		s.nTable = oDtSettings.nTable;
		oDtSettings.aoDrawCallback.unshift( {
			"fn": function () {
				FixedHeader.fnMeasure();
				that._fnUpdateClones.call(that);
				that._fnUpdatePositions.call(that);
			},
			"sName": "FixedHeader"
		} );

		s.bFooter = ($('>tfoot', s.nTable).length > 0) ? true : false;

		/* Add the 'sides' that are fixed */
		if ( s.oSides.top )
		{
			s.aoCache.push( that._fnCloneTable( "fixedHeader", "FixedHeader_Header", that._fnCloneThead ) );
		}
		if ( s.oSides.bottom )
		{
			s.aoCache.push( that._fnCloneTable( "fixedFooter", "FixedHeader_Footer", that._fnCloneTfoot ) );
		}
		if ( s.oSides.left )
		{
			s.aoCache.push( that._fnCloneTable( "fixedLeft", "FixedHeader_Left", that._fnCloneTLeft, s.oSides.left ) );
		}
		if ( s.oSides.right )
		{
			s.aoCache.push( that._fnCloneTable( "fixedRight", "FixedHeader_Right", that._fnCloneTRight, s.oSides.right ) );
		}

		/* Event listeners for window movement */
		FixedHeader.afnScroll.push( function () {
			that._fnUpdatePositions.call(that);
		} );

		$(window).resize( function () {
			FixedHeader.fnMeasure();
			that._fnUpdateClones.call(that);
			that._fnUpdatePositions.call(that);
		} );

		$(s.nTable)
			.on('column-reorder.dt', function () {
				FixedHeader.fnMeasure();
				that._fnUpdateClones( true );
				that._fnUpdatePositions();
			} )
			.on('column-visibility.dt', function () {
				FixedHeader.fnMeasure();
				that._fnUpdateClones( true );
				that._fnUpdatePositions();
			} );

		/* Get things right to start with */
		FixedHeader.fnMeasure();
		that._fnUpdateClones();
		that._fnUpdatePositions();

		s.bInitComplete = true;
	},


	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Support functions
	 */

	/*
	 * Function: fnInitSettings
	 * Purpose:  Take the user's settings and copy them to our local store
	 * Returns:  -
	 * Inputs:   object:s - the local settings object
	 *           object:oInit - the user's settings object
	 */
	fnInitSettings: function ( s, oInit )
	{
		if ( oInit !== undefined )
		{
			if ( oInit.top !== undefined ) {
				s.oSides.top = oInit.top;
			}
			if ( oInit.bottom !== undefined ) {
				s.oSides.bottom = oInit.bottom;
			}
			if ( typeof oInit.left == 'boolean' ) {
				s.oSides.left = oInit.left ? 1 : 0;
			}
			else if ( oInit.left !== undefined ) {
				s.oSides.left = oInit.left;
			}
			if ( typeof oInit.right == 'boolean' ) {
				s.oSides.right = oInit.right ? 1 : 0;
			}
			else if ( oInit.right !== undefined ) {
				s.oSides.right = oInit.right;
			}

			if ( oInit.zTop !== undefined ) {
				s.oZIndexes.top = oInit.zTop;
			}
			if ( oInit.zBottom !== undefined ) {
				s.oZIndexes.bottom = oInit.zBottom;
			}
			if ( oInit.zLeft !== undefined ) {
				s.oZIndexes.left = oInit.zLeft;
			}
			if ( oInit.zRight !== undefined ) {
				s.oZIndexes.right = oInit.zRight;
			}

			if ( oInit.offsetTop !== undefined ) {
				s.oOffset.top = oInit.offsetTop;
			}
			if ( oInit.alwaysCloneTop !== undefined ) {
				s.oCloneOnDraw.top = oInit.alwaysCloneTop;
			}
			if ( oInit.alwaysCloneBottom !== undefined ) {
				s.oCloneOnDraw.bottom = oInit.alwaysCloneBottom;
			}
			if ( oInit.alwaysCloneLeft !== undefined ) {
				s.oCloneOnDraw.left = oInit.alwaysCloneLeft;
			}
			if ( oInit.alwaysCloneRight !== undefined ) {
				s.oCloneOnDraw.right = oInit.alwaysCloneRight;
			}
		}
	},

	/*
	 * Function: _fnCloneTable
	 * Purpose:  Clone the table node and do basic initialisation
	 * Returns:  -
	 * Inputs:   -
	 */
	_fnCloneTable: function ( sType, sClass, fnClone, iCells )
	{
		var s = this.fnGetSettings();
		var nCTable;

		/* We know that the table _MUST_ has a DIV wrapped around it, because this is simply how
		 * DataTables works. Therefore, we can set this to be relatively position (if it is not
		 * alreadu absolute, and use this as the base point for the cloned header
		 */
		if ( $(s.nTable.parentNode).css('position') != "absolute" )
		{
			s.nTable.parentNode.style.position = "relative";
		}

		/* Just a shallow clone will do - we only want the table node */
		nCTable = s.nTable.cloneNode( false );
		nCTable.removeAttribute( 'id' );

		var nDiv = document.createElement( 'div' );
		nDiv.style.position = "absolute";
		nDiv.style.top = "0px";
		nDiv.style.left = "0px";
		nDiv.className += " FixedHeader_Cloned "+sType+" "+sClass;

		/* Set the zIndexes */
		if ( sType == "fixedHeader" )
		{
			nDiv.style.zIndex = s.oZIndexes.top;
		}
		if ( sType == "fixedFooter" )
		{
			nDiv.style.zIndex = s.oZIndexes.bottom;
		}
		if ( sType == "fixedLeft" )
		{
			nDiv.style.zIndex = s.oZIndexes.left;
		}
		else if ( sType == "fixedRight" )
		{
			nDiv.style.zIndex = s.oZIndexes.right;
		}

		/* remove margins since we are going to position it absolutely */
		nCTable.style.margin = "0";

		/* Insert the newly cloned table into the DOM, on top of the "real" header */
		nDiv.appendChild( nCTable );
		document.body.appendChild( nDiv );

		return {
			"nNode": nCTable,
			"nWrapper": nDiv,
			"sType": sType,
			"sPosition": "",
			"sTop": "",
			"sLeft": "",
			"fnClone": fnClone,
			"iCells": iCells
		};
	},

	/*
	 * Function: _fnMeasure
	 * Purpose:  Get the current positioning of the table in the DOM
	 * Returns:  -
	 * Inputs:   -
	 */
	_fnMeasure: function ()
	{
		var
			s = this.fnGetSettings(),
			m = s.oMes,
			jqTable = $(s.nTable),
			oOffset = jqTable.offset(),
			iParentScrollTop = this._fnSumScroll( s.nTable.parentNode, 'scrollTop' ),
			iParentScrollLeft = this._fnSumScroll( s.nTable.parentNode, 'scrollLeft' );

		m.iTableWidth = jqTable.outerWidth();
		m.iTableHeight = jqTable.outerHeight();
		m.iTableLeft = oOffset.left + s.nTable.parentNode.scrollLeft;
		m.iTableTop = oOffset.top + iParentScrollTop;
		m.iTableRight = m.iTableLeft + m.iTableWidth;
		m.iTableRight = FixedHeader.oDoc.iWidth - m.iTableLeft - m.iTableWidth;
		m.iTableBottom = FixedHeader.oDoc.iHeight - m.iTableTop - m.iTableHeight;
	},

	/*
	 * Function: _fnSumScroll
	 * Purpose:  Sum node parameters all the way to the top
	 * Returns:  int: sum
	 * Inputs:   node:n - node to consider
	 *           string:side - scrollTop or scrollLeft
	 */
	_fnSumScroll: function ( n, side )
	{
		var i = n[side];
		while ( n = n.parentNode )
		{
			if ( n.nodeName == 'HTML' || n.nodeName == 'BODY' )
			{
				break;
			}
			i = n[side];
		}
		return i;
	},

	/*
	 * Function: _fnUpdatePositions
	 * Purpose:  Loop over the fixed elements for this table and update their positions
	 * Returns:  -
	 * Inputs:   -
	 */
	_fnUpdatePositions: function ()
	{
		var s = this.fnGetSettings();
		this._fnMeasure();

		for ( var i=0, iLen=s.aoCache.length ; i<iLen ; i++ )
		{
			if ( s.aoCache[i].sType == "fixedHeader" )
			{
				this._fnScrollFixedHeader( s.aoCache[i] );
			}
			else if ( s.aoCache[i].sType == "fixedFooter" )
			{
				this._fnScrollFixedFooter( s.aoCache[i] );
			}
			else if ( s.aoCache[i].sType == "fixedLeft" )
			{
				this._fnScrollHorizontalLeft( s.aoCache[i] );
			}
			else
			{
				this._fnScrollHorizontalRight( s.aoCache[i] );
			}
		}
	},

	/*
	 * Function: _fnUpdateClones
	 * Purpose:  Loop over the fixed elements for this table and call their cloning functions
	 * Returns:  -
	 * Inputs:   -
	 */
	_fnUpdateClones: function ( full )
	{
		var s = this.fnGetSettings();

		if ( full ) {
			// This is a little bit of a hack to force a full clone draw. When
			// `full` is set to true, we want to reclone the source elements,
			// regardless of the clone-on-draw settings
			s.bInitComplete = false;
		}

		for ( var i=0, iLen=s.aoCache.length ; i<iLen ; i++ )
		{
			s.aoCache[i].fnClone.call( this, s.aoCache[i] );
		}

		if ( full ) {
			s.bInitComplete = true;
		}
	},


	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Scrolling functions
	 */

	/*
	 * Function: _fnScrollHorizontalLeft
	 * Purpose:  Update the positioning of the scrolling elements
	 * Returns:  -
	 * Inputs:   object:oCache - the cached values for this fixed element
	 */
	_fnScrollHorizontalRight: function ( oCache )
	{
		var
			s = this.fnGetSettings(),
			oMes = s.oMes,
			oWin = FixedHeader.oWin,
			oDoc = FixedHeader.oDoc,
			nTable = oCache.nWrapper,
			iFixedWidth = $(nTable).outerWidth();

		if ( oWin.iScrollRight < oMes.iTableRight )
		{
			/* Fully right aligned */
			this._fnUpdateCache( oCache, 'sPosition', 'absolute', 'position', nTable.style );
			this._fnUpdateCache( oCache, 'sTop', oMes.iTableTop+"px", 'top', nTable.style );
			this._fnUpdateCache( oCache, 'sLeft', (oMes.iTableLeft+oMes.iTableWidth-iFixedWidth)+"px", 'left', nTable.style );
		}
		else if ( oMes.iTableLeft < oDoc.iWidth-oWin.iScrollRight-iFixedWidth )
		{
			/* Middle */
			this._fnUpdateCache( oCache, 'sPosition', 'fixed', 'position', nTable.style );
			this._fnUpdateCache( oCache, 'sTop', (oMes.iTableTop-oWin.iScrollTop)+"px", 'top', nTable.style );
			this._fnUpdateCache( oCache, 'sLeft', (oWin.iWidth-iFixedWidth)+"px", 'left', nTable.style );
		}
		else
		{
			/* Fully left aligned */
			this._fnUpdateCache( oCache, 'sPosition', 'absolute', 'position', nTable.style );
			this._fnUpdateCache( oCache, 'sTop', oMes.iTableTop+"px", 'top', nTable.style );
			this._fnUpdateCache( oCache, 'sLeft', oMes.iTableLeft+"px", 'left', nTable.style );
		}
	},

	/*
	 * Function: _fnScrollHorizontalLeft
	 * Purpose:  Update the positioning of the scrolling elements
	 * Returns:  -
	 * Inputs:   object:oCache - the cached values for this fixed element
	 */
	_fnScrollHorizontalLeft: function ( oCache )
	{
		var
			s = this.fnGetSettings(),
			oMes = s.oMes,
			oWin = FixedHeader.oWin,
			oDoc = FixedHeader.oDoc,
			nTable = oCache.nWrapper,
			iCellWidth = $(nTable).outerWidth();

		if ( oWin.iScrollLeft < oMes.iTableLeft )
		{
			/* Fully left align */
			this._fnUpdateCache( oCache, 'sPosition', 'absolute', 'position', nTable.style );
			this._fnUpdateCache( oCache, 'sTop', oMes.iTableTop+"px", 'top', nTable.style );
			this._fnUpdateCache( oCache, 'sLeft', oMes.iTableLeft+"px", 'left', nTable.style );
		}
		else if ( oWin.iScrollLeft < oMes.iTableLeft+oMes.iTableWidth-iCellWidth )
		{
			this._fnUpdateCache( oCache, 'sPosition', 'fixed', 'position', nTable.style );
			this._fnUpdateCache( oCache, 'sTop', (oMes.iTableTop-oWin.iScrollTop)+"px", 'top', nTable.style );
			this._fnUpdateCache( oCache, 'sLeft', "0px", 'left', nTable.style );
		}
		else
		{
			/* Fully right align */
			this._fnUpdateCache( oCache, 'sPosition', 'absolute', 'position', nTable.style );
			this._fnUpdateCache( oCache, 'sTop', oMes.iTableTop+"px", 'top', nTable.style );
			this._fnUpdateCache( oCache, 'sLeft', (oMes.iTableLeft+oMes.iTableWidth-iCellWidth)+"px", 'left', nTable.style );
		}
	},

	/*
	 * Function: _fnScrollFixedFooter
	 * Purpose:  Update the positioning of the scrolling elements
	 * Returns:  -
	 * Inputs:   object:oCache - the cached values for this fixed element
	 */
	_fnScrollFixedFooter: function ( oCache )
	{
		var
			s = this.fnGetSettings(),
			oMes = s.oMes,
			oWin = FixedHeader.oWin,
			oDoc = FixedHeader.oDoc,
			nTable = oCache.nWrapper,
			iTheadHeight = $("thead", s.nTable).outerHeight(),
			iCellHeight = $(nTable).outerHeight();

		if ( oWin.iScrollBottom < oMes.iTableBottom )
		{
			/* Below */
			this._fnUpdateCache( oCache, 'sPosition', 'absolute', 'position', nTable.style );
			this._fnUpdateCache( oCache, 'sTop', (oMes.iTableTop+oMes.iTableHeight-iCellHeight)+"px", 'top', nTable.style );
			this._fnUpdateCache( oCache, 'sLeft', oMes.iTableLeft+"px", 'left', nTable.style );
		}
		else if ( oWin.iScrollBottom < oMes.iTableBottom+oMes.iTableHeight-iCellHeight-iTheadHeight )
		{
			this._fnUpdateCache( oCache, 'sPosition', 'fixed', 'position', nTable.style );
			this._fnUpdateCache( oCache, 'sTop', (oWin.iHeight-iCellHeight)+"px", 'top', nTable.style );
			this._fnUpdateCache( oCache, 'sLeft', (oMes.iTableLeft-oWin.iScrollLeft)+"px", 'left', nTable.style );
		}
		else
		{
			/* Above */
			this._fnUpdateCache( oCache, 'sPosition', 'absolute', 'position', nTable.style );
			this._fnUpdateCache( oCache, 'sTop', (oMes.iTableTop+iCellHeight)+"px", 'top', nTable.style );
			this._fnUpdateCache( oCache, 'sLeft', oMes.iTableLeft+"px", 'left', nTable.style );
		}
	},

	/*
	 * Function: _fnScrollFixedHeader
	 * Purpose:  Update the positioning of the scrolling elements
	 * Returns:  -
	 * Inputs:   object:oCache - the cached values for this fixed element
	 */
	_fnScrollFixedHeader: function ( oCache )
	{
		var
			s = this.fnGetSettings(),
			oMes = s.oMes,
			oWin = FixedHeader.oWin,
			oDoc = FixedHeader.oDoc,
			nTable = oCache.nWrapper,
			iTbodyHeight = 0,
			anTbodies = s.nTable.getElementsByTagName('tbody');

		for (var i = 0; i < anTbodies.length; ++i) {
			iTbodyHeight += anTbodies[i].offsetHeight;
		}

		if ( oMes.iTableTop > oWin.iScrollTop + s.oOffset.top )
		{
			/* Above the table */
			this._fnUpdateCache( oCache, 'sPosition', "absolute", 'position', nTable.style );
			this._fnUpdateCache( oCache, 'sTop', oMes.iTableTop+"px", 'top', nTable.style );
			this._fnUpdateCache( oCache, 'sLeft', oMes.iTableLeft+"px", 'left', nTable.style );
		}
		else if ( oWin.iScrollTop + s.oOffset.top > oMes.iTableTop+iTbodyHeight )
		{
			/* At the bottom of the table */
			this._fnUpdateCache( oCache, 'sPosition', "absolute", 'position', nTable.style );
			this._fnUpdateCache( oCache, 'sTop', (oMes.iTableTop+iTbodyHeight)+"px", 'top', nTable.style );
			this._fnUpdateCache( oCache, 'sLeft', oMes.iTableLeft+"px", 'left', nTable.style );
		}
		else
		{
			/* In the middle of the table */
			this._fnUpdateCache( oCache, 'sPosition', 'fixed', 'position', nTable.style );
			this._fnUpdateCache( oCache, 'sTop', s.oOffset.top+"px", 'top', nTable.style );
			this._fnUpdateCache( oCache, 'sLeft', (oMes.iTableLeft-oWin.iScrollLeft)+"px", 'left', nTable.style );
		}
	},

	/*
	 * Function: _fnUpdateCache
	 * Purpose:  Check the cache and update cache and value if needed
	 * Returns:  -
	 * Inputs:   object:oCache - local cache object
	 *           string:sCache - cache property
	 *           string:sSet - value to set
	 *           string:sProperty - object property to set
	 *           object:oObj - object to update
	 */
	_fnUpdateCache: function ( oCache, sCache, sSet, sProperty, oObj )
	{
		if ( oCache[sCache] != sSet )
		{
			oObj[sProperty] = sSet;
			oCache[sCache] = sSet;
		}
	},



	/**
	 * Copy the classes of all child nodes from one element to another. This implies
	 * that the two have identical structure - no error checking is performed to that
	 * fact.
	 *  @param {element} source Node to copy classes from
	 *  @param {element} dest Node to copy classes too
	 */
	_fnClassUpdate: function ( source, dest )
	{
		var that = this;

		if ( source.nodeName.toUpperCase() === "TR" || source.nodeName.toUpperCase() === "TH" ||
			 source.nodeName.toUpperCase() === "TD" || source.nodeName.toUpperCase() === "SPAN" )
		{
			dest.className = source.className;
		}

		$(source).children().each( function (i) {
			that._fnClassUpdate( $(source).children()[i], $(dest).children()[i] );
		} );
	},


	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Cloning functions
	 */

	/*
	 * Function: _fnCloneThead
	 * Purpose:  Clone the thead element
	 * Returns:  -
	 * Inputs:   object:oCache - the cached values for this fixed element
	 */
	_fnCloneThead: function ( oCache )
	{
		var s = this.fnGetSettings();
		var nTable = oCache.nNode;

		if ( s.bInitComplete && !s.oCloneOnDraw.top )
		{
			this._fnClassUpdate( $('thead', s.nTable)[0], $('thead', nTable)[0] );
			return;
		}

		/* Set the wrapper width to match that of the cloned table */
		var iDtWidth = $(s.nTable).outerWidth();
		oCache.nWrapper.style.width = iDtWidth+"px";
		nTable.style.width = iDtWidth+"px";

		/* Remove any children the cloned table has */
		while ( nTable.childNodes.length > 0 )
		{
			$('thead th', nTable).unbind( 'click' );
			nTable.removeChild( nTable.childNodes[0] );
		}

		/* Clone the DataTables header */
		var nThead = $('thead', s.nTable).clone(true)[0];
		nTable.appendChild( nThead );

		/* Copy the widths across - apparently a clone isn't good enough for this */
		var a = [];
		var b = [];

		$("thead>tr th", s.nTable).each( function (i) {
			a.push( $(this).width() );
		} );

		$("thead>tr td", s.nTable).each( function (i) {
			b.push( $(this).width() );
		} );

		$("thead>tr th", s.nTable).each( function (i) {
			$("thead>tr th:eq("+i+")", nTable).width( a[i] );
			$(this).width( a[i] );
		} );

		$("thead>tr td", s.nTable).each( function (i) {
			$("thead>tr td:eq("+i+")", nTable).width( b[i] );
			$(this).width( b[i] );
		} );

		// Stop DataTables 1.9 from putting a focus ring on the headers when
		// clicked to sort
		$('th.sorting, th.sorting_desc, th.sorting_asc', nTable).bind( 'click', function () {
			this.blur();
		} );
	},

	/*
	 * Function: _fnCloneTfoot
	 * Purpose:  Clone the tfoot element
	 * Returns:  -
	 * Inputs:   object:oCache - the cached values for this fixed element
	 */
	_fnCloneTfoot: function ( oCache )
	{
		var s = this.fnGetSettings();
		var nTable = oCache.nNode;

		/* Set the wrapper width to match that of the cloned table */
		oCache.nWrapper.style.width = $(s.nTable).outerWidth()+"px";

		/* Remove any children the cloned table has */
		while ( nTable.childNodes.length > 0 )
		{
			nTable.removeChild( nTable.childNodes[0] );
		}

		/* Clone the DataTables footer */
		var nTfoot = $('tfoot', s.nTable).clone(true)[0];
		nTable.appendChild( nTfoot );

		/* Copy the widths across - apparently a clone isn't good enough for this */
		$("tfoot:eq(0)>tr th", s.nTable).each( function (i) {
			$("tfoot:eq(0)>tr th:eq("+i+")", nTable).width( $(this).width() );
		} );

		$("tfoot:eq(0)>tr td", s.nTable).each( function (i) {
			$("tfoot:eq(0)>tr td:eq("+i+")", nTable).width( $(this).width() );
		} );
	},

	/*
	 * Function: _fnCloneTLeft
	 * Purpose:  Clone the left column(s)
	 * Returns:  -
	 * Inputs:   object:oCache - the cached values for this fixed element
	 */
	_fnCloneTLeft: function ( oCache )
	{
		var s = this.fnGetSettings();
		var nTable = oCache.nNode;
		var nBody = $('tbody', s.nTable)[0];

		/* Remove any children the cloned table has */
		while ( nTable.childNodes.length > 0 )
		{
			nTable.removeChild( nTable.childNodes[0] );
		}

		/* Is this the most efficient way to do this - it looks horrible... */
		nTable.appendChild( $("thead", s.nTable).clone(true)[0] );
		nTable.appendChild( $("tbody", s.nTable).clone(true)[0] );
		if ( s.bFooter )
		{
			nTable.appendChild( $("tfoot", s.nTable).clone(true)[0] );
		}

		/* Remove unneeded cells */
		var sSelector = 'gt(' + (oCache.iCells - 1) + ')';
		$('thead tr', nTable).each( function (k) {
			$('th:' + sSelector, this).remove();
		} );

		$('tfoot tr', nTable).each( function (k) {
			$('th:' + sSelector, this).remove();
		} );

		$('tbody tr', nTable).each( function (k) {
			$('td:' + sSelector, this).remove();
		} );

		this.fnEqualiseHeights( 'thead', nBody.parentNode, nTable );
		this.fnEqualiseHeights( 'tbody', nBody.parentNode, nTable );
		this.fnEqualiseHeights( 'tfoot', nBody.parentNode, nTable );

		var iWidth = 0;
		for (var i = 0; i < oCache.iCells; i++) {
			iWidth += $('thead tr th:eq(' + i + ')', s.nTable).outerWidth();
		}
		nTable.style.width = iWidth+"px";
		oCache.nWrapper.style.width = iWidth+"px";
	},

	/*
	 * Function: _fnCloneTRight
	 * Purpose:  Clone the right most column(s)
	 * Returns:  -
	 * Inputs:   object:oCache - the cached values for this fixed element
	 */
	_fnCloneTRight: function ( oCache )
	{
		var s = this.fnGetSettings();
		var nBody = $('tbody', s.nTable)[0];
		var nTable = oCache.nNode;
		var iCols = $('tbody tr:eq(0) td', s.nTable).length;

		/* Remove any children the cloned table has */
		while ( nTable.childNodes.length > 0 )
		{
			nTable.removeChild( nTable.childNodes[0] );
		}

		/* Is this the most efficient way to do this - it looks horrible... */
		nTable.appendChild( $("thead", s.nTable).clone(true)[0] );
		nTable.appendChild( $("tbody", s.nTable).clone(true)[0] );
		if ( s.bFooter )
		{
			nTable.appendChild( $("tfoot", s.nTable).clone(true)[0] );
		}
		$('thead tr th:lt('+(iCols-oCache.iCells)+')', nTable).remove();
		$('tfoot tr th:lt('+(iCols-oCache.iCells)+')', nTable).remove();

		/* Remove unneeded cells */
		$('tbody tr', nTable).each( function (k) {
			$('td:lt('+(iCols-oCache.iCells)+')', this).remove();
		} );

		this.fnEqualiseHeights( 'thead', nBody.parentNode, nTable );
		this.fnEqualiseHeights( 'tbody', nBody.parentNode, nTable );
		this.fnEqualiseHeights( 'tfoot', nBody.parentNode, nTable );

		var iWidth = 0;
		for (var i = 0; i < oCache.iCells; i++) {
			iWidth += $('thead tr th:eq('+(iCols-1-i)+')', s.nTable).outerWidth();
		}
		nTable.style.width = iWidth+"px";
		oCache.nWrapper.style.width = iWidth+"px";
	},


	/**
	 * Equalise the heights of the rows in a given table node in a cross browser way. Note that this
	 * is more or less lifted as is from FixedColumns
	 *  @method  fnEqualiseHeights
	 *  @returns void
	 *  @param   {string} parent Node type - thead, tbody or tfoot
	 *  @param   {element} original Original node to take the heights from
	 *  @param   {element} clone Copy the heights to
	 *  @private
	 */
	"fnEqualiseHeights": function ( parent, original, clone )
	{
		var that = this;
		var originals = $(parent +' tr', original);
		var height;

		$(parent+' tr', clone).each( function (k) {
			height = originals.eq( k ).css('height');

			// This is nasty :-(. IE has a sub-pixel error even when setting
			// the height below (the Firefox fix) which causes the fixed column
			// to go out of alignment. Need to add a pixel before the assignment
			// Can this be feature detected? Not sure how...
			if ( navigator.appName == 'Microsoft Internet Explorer' ) {
				height = parseInt( height, 10 ) + 1;
			}

			$(this).css( 'height', height );

			// For Firefox to work, we need to also set the height of the
			// original row, to the value that we read from it! Otherwise there
			// is a sub-pixel rounding error
			originals.eq( k ).css( 'height', height );
		} );
	}
};


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Static properties and methods
 *   We use these for speed! This information is common to all instances of FixedHeader, so no
 * point if having them calculated and stored for each different instance.
 */

/*
 * Variable: oWin
 * Purpose:  Store information about the window positioning
 * Scope:    FixedHeader
 */
FixedHeader.oWin = {
	"iScrollTop": 0,
	"iScrollRight": 0,
	"iScrollBottom": 0,
	"iScrollLeft": 0,
	"iHeight": 0,
	"iWidth": 0
};

/*
 * Variable: oDoc
 * Purpose:  Store information about the document size
 * Scope:    FixedHeader
 */
FixedHeader.oDoc = {
	"iHeight": 0,
	"iWidth": 0
};

/*
 * Variable: afnScroll
 * Purpose:  Array of functions that are to be used for the scrolling components
 * Scope:    FixedHeader
 */
FixedHeader.afnScroll = [];

/*
 * Function: fnMeasure
 * Purpose:  Update the measurements for the window and document
 * Returns:  -
 * Inputs:   -
 */
FixedHeader.fnMeasure = function ()
{
	var
		jqWin = $(window),
		jqDoc = $(document),
		oWin = FixedHeader.oWin,
		oDoc = FixedHeader.oDoc;

	oDoc.iHeight = jqDoc.height();
	oDoc.iWidth = jqDoc.width();

	oWin.iHeight = jqWin.height();
	oWin.iWidth = jqWin.width();
	oWin.iScrollTop = jqWin.scrollTop();
	oWin.iScrollLeft = jqWin.scrollLeft();
	oWin.iScrollRight = oDoc.iWidth - oWin.iScrollLeft - oWin.iWidth;
	oWin.iScrollBottom = oDoc.iHeight - oWin.iScrollTop - oWin.iHeight;
};


FixedHeader.version = "2.1.2";


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Global processing
 */

/*
 * Just one 'scroll' event handler in FixedHeader, which calls the required components. This is
 * done as an optimisation, to reduce calculation and proagation time
 */
$(window).scroll( function () {
	FixedHeader.fnMeasure();

	for ( var i=0, iLen=FixedHeader.afnScroll.length ; i<iLen ; i++ ) {
		FixedHeader.afnScroll[i]();
	}
} );


$.fn.dataTable.FixedHeader = FixedHeader;
$.fn.DataTable.FixedHeader = FixedHeader;


return FixedHeader;
}; // /factory


// Define as an AMD module if possible
if ( typeof define === 'function' && define.amd ) {
	define( ['jquery', 'datatables'], factory );
}
else if ( typeof exports === 'object' ) {
    // Node/CommonJS
    factory( require('jquery'), require('datatables') );
}
else if ( jQuery && !jQuery.fn.dataTable.FixedHeader ) {
	// Otherwise simply initialise as normal, stopping multiple evaluation
	factory( jQuery, jQuery.fn.dataTable );
}


})(window, document);

/***** DataTables Bootstrap ****************/
/***** DataTables Bootstrap ****************/
/***** DataTables Bootstrap ****************/
/***** DataTables Bootstrap ****************/

/* Set the defaults for DataTables initialisation */
$.extend( true, $.fn.dataTable.defaults, {
	"sDom":
		"<'row'<'col-xs-6'l><'col-xs-6'f>r>"+
		"t"+
		"<'row'<'col-xs-6'i><'col-xs-6'p>>",
	"oLanguage": {
		"sLengthMenu": "_MENU_ records per page"
	}
} );


/* Default class modification */
$.extend( $.fn.dataTableExt.oStdClasses, {
	"sWrapper": "dataTables_wrapper form-inline",
	"sFilterInput": "form-control input-sm",
	"sLengthSelect": "form-control input-sm"
} );

// In 1.10 we use the pagination renderers to draw the Bootstrap paging,
// rather than  custom plug-in
if ( $.fn.dataTable.Api ) {
	$.fn.dataTable.defaults.renderer = 'bootstrap';
	$.fn.dataTable.ext.renderer.pageButton.bootstrap = function ( settings, host, idx, buttons, page, pages ) {
		var api = new $.fn.dataTable.Api( settings );
		var classes = settings.oClasses;
		var lang = settings.oLanguage.oPaginate;
		var btnDisplay, btnClass;

		var attach = function( container, buttons ) {
			var i, ien, node, button;
			var clickHandler = function ( e ) {
				e.preventDefault();
				if ( e.data.action !== 'ellipsis' ) {
					api.page( e.data.action ).draw( false );
				}
			};

			for ( i=0, ien=buttons.length ; i<ien ; i++ ) {
				button = buttons[i];

				if ( $.isArray( button ) ) {
					attach( container, button );
				}
				else {
					btnDisplay = '';
					btnClass = '';

					switch ( button ) {
						case 'ellipsis':
							btnDisplay = '&hellip;';
							btnClass = 'disabled';
							break;

						case 'first':
							btnDisplay = lang.sFirst;
							btnClass = button + (page > 0 ?
								'' : ' disabled');
							break;

						case 'previous':
							btnDisplay = lang.sPrevious;
							btnClass = button + (page > 0 ?
								'' : ' disabled');
							break;

						case 'next':
							btnDisplay = lang.sNext;
							btnClass = button + (page < pages-1 ?
								'' : ' disabled');
							break;

						case 'last':
							btnDisplay = lang.sLast;
							btnClass = button + (page < pages-1 ?
								'' : ' disabled');
							break;

						default:
							btnDisplay = button + 1;
							btnClass = page === button ?
								'active' : '';
							break;
					}

					if ( btnDisplay ) {
						node = $('<li>', {
								'class': classes.sPageButton+' '+btnClass,
								'aria-controls': settings.sTableId,
								'tabindex': settings.iTabIndex,
								'id': idx === 0 && typeof button === 'string' ?
									settings.sTableId +'_'+ button :
									null
							} )
							.append( $('<a>', {
									'href': '#'
								} )
								.html( btnDisplay )
							)
							.appendTo( container );

						settings.oApi._fnBindAction(
							node, {action: button}, clickHandler
						);
					}
				}
			}
		};

		attach(
			$(host).empty().html('<ul class="pagination"/>').children('ul'),
			buttons
		);
	}
}
else {
	// Integration for 1.9-
	$.fn.dataTable.defaults.sPaginationType = 'bootstrap';

	/* API method to get paging information */
	$.fn.dataTableExt.oApi.fnPagingInfo = function ( oSettings )
	{
		return {
			"iStart":         oSettings._iDisplayStart,
			"iEnd":           oSettings.fnDisplayEnd(),
			"iLength":        oSettings._iDisplayLength,
			"iTotal":         oSettings.fnRecordsTotal(),
			"iFilteredTotal": oSettings.fnRecordsDisplay(),
			"iPage":          oSettings._iDisplayLength === -1 ?
				0 : Math.ceil( oSettings._iDisplayStart / oSettings._iDisplayLength ),
			"iTotalPages":    oSettings._iDisplayLength === -1 ?
				0 : Math.ceil( oSettings.fnRecordsDisplay() / oSettings._iDisplayLength )
		};
	};

	/* Bootstrap style pagination control */
	$.extend( $.fn.dataTableExt.oPagination, {
		"bootstrap": {
			"fnInit": function( oSettings, nPaging, fnDraw ) {
				var oLang = oSettings.oLanguage.oPaginate;
				var fnClickHandler = function ( e ) {
					e.preventDefault();
					if ( oSettings.oApi._fnPageChange(oSettings, e.data.action) ) {
						fnDraw( oSettings );
					}
				};

				$(nPaging).append(
					'<ul class="pagination">'+
						'<li class="prev disabled"><a href="#">&larr; '+oLang.sPrevious+'</a></li>'+
						'<li class="next disabled"><a href="#">'+oLang.sNext+' &rarr; </a></li>'+
					'</ul>'
				);
				var els = $('a', nPaging);
				$(els[0]).bind( 'click.DT', { action: "previous" }, fnClickHandler );
				$(els[1]).bind( 'click.DT', { action: "next" }, fnClickHandler );
			},

			"fnUpdate": function ( oSettings, fnDraw ) {
				var iListLength = 5;
				var oPaging = oSettings.oInstance.fnPagingInfo();
				var an = oSettings.aanFeatures.p;
				var i, ien, j, sClass, iStart, iEnd, iHalf=Math.floor(iListLength/2);

				if ( oPaging.iTotalPages < iListLength) {
					iStart = 1;
					iEnd = oPaging.iTotalPages;
				}
				else if ( oPaging.iPage <= iHalf ) {
					iStart = 1;
					iEnd = iListLength;
				} else if ( oPaging.iPage >= (oPaging.iTotalPages-iHalf) ) {
					iStart = oPaging.iTotalPages - iListLength + 1;
					iEnd = oPaging.iTotalPages;
				} else {
					iStart = oPaging.iPage - iHalf + 1;
					iEnd = iStart + iListLength - 1;
				}

				for ( i=0, ien=an.length ; i<ien ; i++ ) {
					// Remove the middle elements
					$('li:gt(0)', an[i]).filter(':not(:last)').remove();

					// Add the new list items and their event handlers
					for ( j=iStart ; j<=iEnd ; j++ ) {
						sClass = (j==oPaging.iPage+1) ? 'class="active"' : '';
						$('<li '+sClass+'><a href="#">'+j+'</a></li>')
							.insertBefore( $('li:last', an[i])[0] )
							.bind('click', function (e) {
								e.preventDefault();
								oSettings._iDisplayStart = (parseInt($('a', this).text(),10)-1) * oPaging.iLength;
								fnDraw( oSettings );
							} );
					}

					// Add / remove disabled classes from the static elements
					if ( oPaging.iPage === 0 ) {
						$('li:first', an[i]).addClass('disabled');
					} else {
						$('li:first', an[i]).removeClass('disabled');
					}

					if ( oPaging.iPage === oPaging.iTotalPages-1 || oPaging.iTotalPages === 0 ) {
						$('li:last', an[i]).addClass('disabled');
					} else {
						$('li:last', an[i]).removeClass('disabled');
					}
				}
			}
		}
	} );
}
