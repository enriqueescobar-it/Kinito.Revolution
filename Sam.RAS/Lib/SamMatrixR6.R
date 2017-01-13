if (!require("R6")) {
	install.packages("R6", dependencies = TRUE);
	library(R6);
}
#Unlike many objects in R, instances (objects) of R6 classes have reference semantics. R6 classes also support:
#*public and private methods
#*active bindings
#*inheritance (superclasses) which works across packages
SamMatrixR6 <- R6Class("SamMatrixR6",
	# potability this is default
	portable = TRUE,
	# inheritance `inherit` must be a R6ClassGenerator!
	# inherit = data.matrix,
	# region Public
	public = list(
		# region PublicParameters
		IsSquare		= FALSE,
		IsCornerZero	= FALSE,
		IsDiagonalZero	= FALSE,
		Matrix			= NULL,
		HasTotalColumn	= FALSE,
		HasTotalRow		= FALSE,
		LastColumn		= NULL,
		LastRow			= NULL,
		TotalColumn		= NULL,
		TotalRow		= NULL,
		IsTotalColumnZero=FALSE,
		IsTotalRowZero	= FALSE,
		NbNegatives		= -1,
		NbZeros			= -1,
		# endregion PublicParameters
		# region PublicConstructor
		#initialize = function(IsSquare, Matrix) {
		initialize = function(Matrix) {
			reg.finalizer(self, function(e) print("Finalizer has been called!"), onexit = TRUE)
			#if (!missing(IsSquare)) self$IsSquare <- FALSE;
			if (!missing(Matrix)) {
				self$Matrix			<- Matrix;
				self$LastColumn		<- head(Matrix[,ncol(Matrix)],-1);
				self$LastRow		<- head(Matrix[nrow(Matrix),],-1);
				self$NbNegatives	<- sum(Matrix<0);
				self$NbZeros		<- sum(Matrix==0);
				self$IsSquare		<- (ncol(Matrix) == nrow(Matrix));
				self$IsCornerZero	<- !(Matrix[nrow(Matrix),ncol(Matrix)]>0) &
										!(Matrix[nrow(Matrix),ncol(Matrix)]<0);
				if (self$IsSquare) self$IsDiagonalZero <- (sum(diag(Matrix))==0);
				self$SetTotalColumn();
				self$SetTotalRow();
			}
			self$ToString();
		},
		# endregion PublicConstructor
		# region PublicMethods
		GetMatrix = function() {
		  returnValue(self$Matrix);
		},
		SetMatrix = function(val) {
		  self$Matrix <- val;
		},
		SetTotalColumn = function() {
			SC <- NULL;
			for(rowNb in 1:(nrow(self$Matrix)-1)){
				SC[rowNb] <- sum(self$Matrix[rowNb,1:(ncol(self$Matrix)-1)]);
			}
			self$TotalColumn <- SC;
			self$SetHasTotalColumn();
		},
		SetTotalRow = function() {
			SR <- NULL;
			for(colNb in 1:(ncol(self$Matrix)-1)){
				SR[colNb] <- sum(head(self$Matrix[,colNb], -1));
			}
			self$TotalRow <- SR;
			self$SetHasTotalRow();
		},
		SetHasTotalColumn = function() {
			boo <- round(self$LastColumn,1)==round(self$TotalColumn,1);
			self$HasTotalColumn <- (length(self$TotalColumn)==length(self$LastColumn)) &
								(length(self$TotalColumn)==sum(boo==TRUE)) &
								(length(self$LastColumn)==sum(boo==TRUE));
			print(paste0("C_", self$HasTotalColumn));
			if (!self$HasTotalColumn) self$CheckLastColumn();
			self$IsTotalColumnZero <- sum(self$TotalColumn)==0;
		},
		SetHasTotalRow = function() {
			boo <- round(self$LastRow,1)==round(self$TotalRow,1);
			self$HasTotalRow <- ((length(self$TotalRow)==length(self$LastRow)) &
								(length(self$TotalRow)==sum(boo==TRUE)) &
								(length(self$LastRow)==sum(boo==TRUE)));
			print(paste0("R_", self$HasTotalRow));
			if (!self$HasTotalRow) self$CheckLastRow();
			self$IsTotalRowZero <- sum(self$TotalRow)==0;
		},
		CheckLastColumn = function() {
			print("Checking TotalColumn from Original Matrix");
			# self$Matrix <- self$Matrix[,0-ncol(self$Matrix)];
		},
		CheckLastRow = function() {
			print("Checking TotalRow    from Original Matrix");
			# self$Matrix <- self$Matrix[0-nrow(self$Matrix),];
		},
		ToString = function() {
			cat(paste0("SamMatrixR6\n\tIsSquare:\t\t", self$IsSquare, "\n\tIsDiagonalZero:\t", self$IsDiagonalZero, "\n", 
				"\tIsCornerZero:\t", self$IsCornerZero, "\n\tNbZeros:\t\t", self$NbZeros, "\n",
 				"\tNbNegatives:\t", self$NbNegatives,"\n",
				"\tHasTotalColumn:\t", self$HasTotalColumn, "\n\tNullTotalColumn:", self$IsTotalColumnZero,"\n",
				"\tHasTotalRow:\t", self$HasTotalRow, "\n\tNullTotalRow:\t", self$IsTotalRowZero, "\n"));
		}
		# endregion PublicMethods
	),
	# endregion Public
	# region Private
	private = list(
		#mMatrix = NULL
	)
	# endregion Private
)