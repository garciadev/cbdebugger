<cfoutput>
<!--- Start Rendering the Execution Profiler panel  --->
<div class="fw_titles" onClick="fw_toggle( 'fw_executionprofiler' )">
	<span style="float: right;">
		v#getModuleConfig( "cbdebugger" ).version#
	</span>
	<div class="cbd-flex ml5">
		<div>
			<img src="#event.getModuleRoot( 'cbDebugger' )#/includes/images/coldbox_16.png" class="">
		</div>

		<div class="ml5">
			ColdBox Request Tracker
			<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
				<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3" />
			</svg>
			#event.getCurrentEvent()#
		</div>
	</div>
</div>

<div class="fw_debugContentView" id="fw_executionprofiler">

	<!--- Toolbar --->
	<div class="floatRight">
		<form name="fw_reinitcoldbox" id="fw_reinitcoldbox" action="#args.urlBase#" method="POST">
			<input type="hidden" name="fwreinit" id="fwreinit" value="">

			<!--- Auto Refresh Frequency --->
			<select
				id="cbdAutoRefresh"
				onChange="cbdStartDebuggerMonitor( this.value )">
					<option value="0">No Auto-Refresh</option>
					<option value="2" <cfif args.refreshFrequency eq 2>selected</cfif>>2 Seconds</option>
					<option value="3" <cfif args.refreshFrequency eq 3>selected</cfif>>3 Seconds</option>
					<cfloop from="5" to="30" index="i" step="5">
						<option value="#i#" <cfif args.refreshFrequency eq i>selected</cfif>>#i# Seconds</option>
					</cfloop>
			</select>

			<!--- Reinit --->
			<button
				title="Reinitialize the framework."
				onClick="fw_reinitframework( #iif( controller.getSetting( 'ReinitPassword' ).length(), 'true', 'false' )#)"
			>
				<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
					<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
				</svg>
			</button>

			<!--- Refresh Profilers --->
			<button
				type="button"
				title="Refresh the profilers"
				id="cbd-buttonRefreshProfilers"
				onClick="cbdRefreshProfilers()"
			>
				<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
					<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
				</svg>
			</button>

			<!--- Clear Profilers --->
			<button
				type="button"
				title="Clear the profilers"
				id="cbd-buttonClearProfilers"
				onClick="cbdClearProfilers()"
			>
				<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
					<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
				</svg>
			</button>

			<!--- Turn Debugger Off --->
			<button
				title="Turn the ColdBox Debugger Off"
				onClick="window.location='#args.urlBase#?debugmode=false'"
			>
				<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
					<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
				</svg>
			</button>
		</form>
	</div>

	<!--- Info --->
	<p>
		Below you can see the latest ColdBox requests made into the application.
		Click on the desired profiler to view its execution report.
	</p>

	<!--- Machine Info --->
	<div class="fw_debugTitleCell">
		Framework Info:
	</div>
	<div class="fw_debugContentCell">
		#controller.getColdboxSettings().codename#
		#controller.getColdboxSettings().version#
		#controller.getColdboxSettings().suffix#
	</div>

	<!--- App Name + Environment --->
	<div class="fw_debugTitleCell">
		Application Name:
	</div>
	<div class="fw_debugContentCell">
		#controller.getSetting( "AppName" )#
		<span class="fw_purpleText">
			(environment=#controller.getSetting( "Environment" )#)
		</span>
	</div>

	<!--- App Name + Environment --->
	<div class="fw_debugTitleCell">
		CFML Engine:
	</div>
	<div class="fw_debugContentCell">
		#args.environment.cfmlEngine#
		#args.environment.cfmlVersion#
		/
		Java #args.environment.javaVersion#
	</div>

	<!--- Render Profilers --->
	<a name="cbd-profilers"></a>
	<div id="cbd-profilers">
		#renderView(
			view : "main/partials/profilers",
			module : "cbdebugger",
			args : {
				environment : args.environment,
				profilers : args.profilers,
				debuggerConfig : args.debuggerConfig
			},
			prePostExempt : true
		)#
	</div>

</div>
<!--- **************************************************************--->
</cfoutput>