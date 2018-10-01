# scale operator

#### Description
`scale` operator performs a scaling of the data

##### Usage
Input projection|.
---|---
`row`   | represents the variables (e.g. channels, markers, genes)
`col`   | represents the observations (e.g. cells, samples, indviduals) 
`y-axis`| measurement value


Input parameters|.
---|---
`scale`   | logical, if scale is `TRUE` then scaling is done by dividing the (centered) row of x by their standard deviations if center is TRUE, and the root mean square otherwise. If scale is `FALSE`, no scaling is done.
`center`  | If center is `TRUE` then centering is done by subtracting the row means (omitting NAs) of x from their corresponding columns, and if center is `FALSE`, no centering is done.


Output relations|.
---|---
`scale`| numeric, per cell

##### Details
The operator is the `scale` function in base R .


#### References
see the `base::scale` function of the R package for the documentation, 


##### See Also


#### Examples


