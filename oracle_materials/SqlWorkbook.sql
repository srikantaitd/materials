--AD or BC Indicator
SELECT TO_CHAR(SYSDATE,'A.D.') FROM DUAL;
--Am or PM Indicator
SELECT TO_CHAR(SYSDATE,'AM') FROM DUAL;
--Century Indicator
SELECT TO_CHAR(SYSDATE,'CC') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'SCC') FROM DUAL;
--Numeric WeekDay Indicator
SELECT TO_CHAR(SYSDATE,'D') FROM DUAL;
--Full Day Name Indicator
SELECT TO_CHAR(SYSDATE,'DAY') FROM DUAL;
--Abbribated Day Name Indicator
SELECT TO_CHAR(SYSDATE,'DY') FROM DUAL;
--Numeric Month Day Indicator
SELECT TO_CHAR(SYSDATE,'DD') FROM DUAL;
--Numeric Year Day Indicator
SELECT TO_CHAR(SYSDATE,'DDD') FROM DUAL;
--Week Of the Month Indicator
SELECT TO_CHAR(SYSDATE,'W') FROM DUAL;
--Week Of the Year Indicator
SELECT TO_CHAR(SYSDATE,'WW') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'IW') FROM DUAL;
--Numeric Month Indicator
SELECT TO_CHAR(SYSDATE,'MM') FROM DUAL;
--Abbribated Month Indicator
SELECT TO_CHAR(SYSDATE,'MON') FROM DUAL;
--Full Month Name Indicator
SELECT TO_CHAR(SYSDATE,'MONTH') FROM DUAL;
--ROMAN Month Indicator
SELECT TO_CHAR(SYSDATE,'RM') FROM DUAL;
-- Four digit Numeric Year Indicator
SELECT TO_CHAR(SYSDATE,'YYYY') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'IYYY') FROM DUAL;
--Full Year Name Indicator
SELECT TO_CHAR(SYSDATE,'Year') FROM DUAL;
--Quarter Of The Year Indicator
SELECT TO_CHAR(SYSDATE,'Q') FROM DUAL;
--Julian Day Of The Year Indicator
SELECT TO_CHAR(SYSDATE,'J') FROM DUAL;
--12Hour Indicator
SELECT TO_CHAR(SYSDATE,'HH') FROM DUAL;
--24Hour Indicator
SELECT TO_CHAR(SYSDATE,'HH24') FROM DUAL;
--Second Indicator
SELECT TO_CHAR(SYSDATE,'SS') FROM DUAL;
--Minute Indicator
SELECT TO_CHAR(SYSDATE,'MI') FROM DUAL;
--Seconds Past Indicator
SELECT TO_CHAR(SYSDATE,'SSSSS') FROM DUAL;
--Suffix Indicator
SELECT TO_CHAR(SYSDATE,'DDTH-Month-YYYYSP') FROM DUAL;

--FillMode Indicator
SELECT TO_CHAR(SYSDATE,'FMDD-MON-YYYY') FROM DUAL;



SubQuery
========

MultipleRow SubQuery:
--------------------
-- Get the details of all the employees who are earning equal to the investment on department 20 employees hiredate.
SELECT Ename,Job,Sal,Deptno
FROM Emp
WHERE Sal IN
	(
	SELECT Sal
	FROM Emp
	WHERE HireDate IN
		(
		 SELECT HireDate
		 FROM Emp
		 WHERE Deptno=20
		)
	)
-- Get the details of all the department who are earning equal to the investment on SALES department employees recuirtment date
SELECT Ename,Job,Sal,Deptno
FROM Emp
WHERE Sal IN
	(
	SELECT Sal
	WHERE HireDate IN 
		(
		SELECT HireDate
		FROM Emp
		WHERE Deptno=
			(
			SELECT Deptno
			FROM Emp
			WHERE Ename='SALES'
			)
		)
	)
	
-- Get the details of all the employee who are earning equal to least investment of the department.

SELECT Ename,Job,Sal,Deptno
FROM Emp
WHERE Sal IN 
	(
	SELECT MIN(Sal)
	FROM Emp
	GROUP BY Deptno;
	);

	
--Get the details of all the employee who are earning below the minimum investments of the department.

SELECT Ename,Job,Sal,Deptno
FROM Emp
WHERE Sal <ANY 
	(
	 SELECT MIN(Sal)
	 FROM Emp
	 GROUP BY Deptno
	 )
	 
--Get the details of all employee who are earning below the highest of the least investments of departments

SELECT Ename,Job,Sal,Deptno
FROM Emp
WHERE Sal <
	(
	SELECT MAX(MIN(Sal))
	FROM Emp
	GROUP By Deptno;
	)
	
--Get the details of the employees who are earning below the highest of the lowest investments in SALES department.

SELECT Ename,Job,Sal,Deptno
FROM Emp
WHERE Sal <ANY
	(
	SELECT Sal
	FROM Emp
	WHERE Deptno=
		(
		SELECT Deptno
		FROM Dept
		WHERE Dname='SALES'
		)
	);
	
	(or)

SELECT Ename,Job,Sal,Deptno
FROM Emp
WHERE Sal <
	(
	SELECT MAX(Sal)
	FROM Emp
	WHERE Deptno=
		(
		SELECT Deptno
		FROM Dept
		WHERE Dname='SALES'
		)
	)	;
	
--Get the details of all the employee who are earning below the investments of CLERKs.
SELECT Ename,Job,Sal,Deptno
FROM Emp
WHERE Sal < ANY 
	(
	SELECT Sal
	FROM Emp
	WHERE Job='CLERK'
	);

--Get the details of all the employee who are earning below the highest invested CLERK.
SELECT Ename,Job,Sal,Deptno
FROM Emp
WHERE Sal < 
		(
		SELECT MAX(Sal)
		FROM Emp
		WHERE Job='CLERK'
		)

--Get the details of all the employees who are earning below the minimum investments in SALES department other than CLERK Designation.
SELECT Ename,Job,Sal,Deptno
FROM Emp
WHERE Sal<
	(
	SELECT MAX(Sal)
	FROM Emp
	WHERE Deptno=
		(
		SELECT Deptno
		FROM Emp
		WHERE Dname='SALES'
		)
	) AND Job <> 'CLERK';
	

--Get the details of all the employee who are earning more than the minimum investments of the departments.
SELECT Enmae,Job,Sal,Deptno
FROM Emp
WHERE Sal >ANY 
	(
	SELECT MIN(Sal)
	FROM Emp
	GROUP BY Deptno
	)

--Get the details of all employee who are earning more than the  least investments of department 30
SELECT Ename,Job,Sal,Deptno
FROM Emp
WHERE Sal > 
	(
	SELECT MIN(Sal)
	FROM Emp
	WHERE Deptno=30
	);
	
--Get the details of all the employees who are earning more than the minimum investments in SALES department.
SELECT Ename,Job,Sal,Deptno
FROM Emp
WHERE Sal > 
	(
	SELECT MIN(Sal)
	FROM Emp
	WHERE Deptno=
		(
		SELECT Deptno
		FROM Dept
		WHERE Dname='SALES'
		)
	);
	
--Get the details of all the employee who are earning more than the investments of CLERKs.
		(or)
--Get the details of all the employee who are earning more than the highest invested CLERK.

SELECT Ename,Job,Sal,Deptno
FROM Emp
WHERE Sal > 
	(
	SELECT MIN(Sal)
	FROM Emp
	WHERE Job='CLERK'
	);
	(or)
SELECT Ename,Job,Sal,Deptno
FROM Emp
WHERE Sal > ANY
	(
	SELECT Sal
	FROM Emp
	WHERE Job='CLERK'
	);


--Get the details of all the employees who are earning more than the highest of the lowest investments in SALES department other than CLERK Designation.
SELECT Ename,Job,Sal,Deptno
FROM Emp
WHERE Sal > 
	(
	SELECT MIN(MIN(Sal))
	FROM Emp
	GROUP BY Deptno
	) AND Job <> CLERK;
	
SingleRow SubQuery:
-------------------
-- Get the details  of all the emmployee who is earning equal to the investments on TURNER.
SELECT Ename,Job,Sal,Deptno
FROM Emp
WHERE Sal=
	(
	SELECT Sal
	FROM Emp
	WHERE Ename='TURNER' AND Deptno=30;
	)

-- Get the details of all the employees who are earning least investment in the Organization.
SELECT Ename,Job,Sal,Deptno
FROM Emp
WHERE Sal=
	(
	SELECT MIN(Sal)
	FROM Emp
	);

-- Get the details of the Job having least average investment
SELECT Job,AVG(Sal)
FROM Emp
GROUP BY Job
HAVING AVG(Sal) =
	(
	SELECT MIN(AVG(Sal))
	FROM Emp
	GROUP BY Job;
	);

Corelated Subqueries:
--------------------
-- Get the details of all the department information where employees are working.
	1.
	SELECT DISTINCT D.Dname,D.Deptno,D.Loc
	FROM Dept D 
		INNER JOIN Emp E ON E.Deptno=D.Deptno
		
	2.
	SELECT D.Dname,D.Deptno,D.Loc
	FROM Dept D,Emp E
	WHERE DE.Deptno=D.Deptno
	GROUP BY D.Deptno
	
	3.
	SELECT DISTINCT D.Deptno,D.Dname,D.Loc
	FROM Dept D
	WHERE Deptno IN
		(
		SELECT Deptno
		FROM Emp E
		)
	
	4.
	SELECT D.Deptno,D.Dname,D.Loc
	FROM Dept D,
		(
		SELECT Deptno
		FROM Emp 
		) E
	WHERE E.Deptno=D.Deptno;
	
	5.
	SELECT D.Deptno,D.Dname,D.Loc
	FROM Dept D
	WHERE D.Deptno IN
		(
		SELECT Deptno
		FROM Emp E
		WHERE E.Deptno=D.Deptno
		)
	6.
	SELECT D.Deptno,D.Dname,D.Loc
	FROM Dept D
	WHERE EXISTS
		(
		SELECT Deptno
		FROM Emp E
		WHERE E.Deptno=D.Deptno
		);
		
	7.
	SELECT D.Deptno,D.Dname,D.Loc
	FROM Dept D
	WHERE EXISTS
		(
		SELECT *
		FROM Emp E
		WHERE E.Deptno=D.Deptno
		);

	8.
	SELECT D.Deptno,D.Dname,D.Loc
	FROM Dept D
	WHERE EXISTS
		(
		SELECT 1
		FROM Emp E
		WHERE E.Deptno=D.Deptno
		);
		
-- Get the details of the department where employees are not working.
	SELECT D.Deptno,D.Dname,D.Loc
	FROM Dept D
	WHERE NOT EXISTS
		(
		SELECT 1
		FROM Emp E
		WHERE E.Deptno=D.Deptno
		)
		
-- Get the details of all the employees who are having managers.
	1.
	SELECT E.Ename,E.Job,E.Sal,E.Deptno
	FROM Emp E
	WHERE EXISTS
		(
		SELECT 1
		FROM Emp M 
		WHERE E.MGR=M.Empno
		)
-- Get the details of all the employees who are not having managers.
	1.
	SELECT E.Ename,E.Job,E.Sal,E.Deptno
	FROM Emp E
	WHERE NOT EXISTS
		(
		SELECT 1
		FROM Emp M 
		WHERE E.MGR=M.Empno
		)
		
-- Get the details of all the employees are managing atleast one employees.
	1.
	SELECT E.Ename,E.Job,E.Sal,E.Deptno
	FROM Emp E
	WHERE EXISTS
		(
		SELECT 1
		FROM Emp M
		WHERE M.MGR=E.Empno
		);
		
-- Get all the Employee information who are only employees.
	SELECT E.Ename,E.Job,E.Sal,E.Deptno
	FROM Emp E
	WHERE NOT EXISTS
		(
		SELECT 1
		FROM Emp M
		WHERE M.MGR=E.Empno
		);
	
-- Get the details of all the employee who are having commision.
	SELECT E.Ename,E.Job,E.Sal,E.Deptno
	FROM Emp E
	WHERE EXISTS
		(
		SELECT 1
		FROM Emp C
		WHERE C.Comm=E.Comm
		)

-- Get the details of all the employees who are not having commision.
	SELECT E.Ename,E.Job,E.Sal,E.Deptno
	FROM Emp E
	WHERE NOT EXISTS
		(
		SELECT 1
		FROM Emp C
		WHERE C.Comm=E.Comm
		)
-- Demonstrate the usage of WITH clause in Subquery.
	--> Get the details of the employee along with their their managers details
	1.
	SELECT Emp.Ename,Emp.Job EmpJob,ED.Dname EmpDept,
		   Mgr.Ename MgrName,Mgr.Job MgrJob,MD.Dname MgrDept
	FROM Emp Emp,Dept ED,Emp Mgr,Dept MD
	WHERE Emp.MGR=Mgr.Empno AND Emp.Deptno=ED.Deptno AND Mgr.Deptno=MD.Deptno;
	
	2.
	SELECT Emp.Ename,Emp.Job EmpJob,Emp.Sal EmpSal,Emp.Deptno EmpDept,
		   Mgr.Ename MgrName,Mgr.Job MgrJob,Mgr.Sal MgrSal,Mgr.Deptno MgrDept
	FROM Emp Emp
	WHERE 

Hirarchical Or Recursive Queries
--------------------------------
- Hierarchical Queries Are Those Queries That Are Executed Upon Table Which Contains Hierarchical Data.

- Hierarchy and Relation Are Two Different Sides Of The Same Coin. It is Our Responsibility to Know How To Turn And Twist The Point To Present Which Priciple.
- Every Table Stores Data In Relational Format. So Relation Is A Storage Principle, And Hirarchy Is A Presentation Principle.

- When A Hierarchy Has To Be Represented It Has To Be Represented In Presentation. Storage Is Always In Relational.

- When A Hierarchy Exists, It Should Start From Somewhere And Definitely End Somewhere. So To Identify The Starting Element   Node In The Hierarchy Oracle Provides A Special Component Called START WITH Clause Which Always Contains A Condition That Needs To Be Satisified To Confirm Any Element As A Root Element From Where The Hierarchy Should Begin. 

-The START WITH Clause Is Always Executes Once To Identify The Rot Element(s) Of The Hierarchy, Once The Root Node(s) Is Confirmed ,The Job Of START WITH Clause is Finished. Next It Delegates All The Responsibility To CONNECT BY Clause.

-When The Parent Record Is Identified ,It Is Essential To Find Out The Successive Next Generation Child Nodes Which Are Linked To That Parent Node. For That Purpose Oracle Provides A Special Component Called CONNECT  BY Clause Represents A Condition
Which Needs To Be Satisfied By The Child Nodes. CONNECT BY CLAUSE Along With PRIOR Operator Always Represents A Parent-Child Relation.

-PRIOR Operator Has The Inteligence Of Remembering The Address Of The Previous Node,Which In Turn Helps The CONNECT BY Clause To Maintain The Parent Child Relation In The Hierarchy.

-CONNECT BY Clause In Oracle Is Designed In Such A Way That It Concentrates On The Current Record ,Considering That 
Current Record As The Parent Record,Tries To Identify The Child Records By Understanding The Logic Written In CONNECT BY Clause ,In That Way It Will Be Going On Identifying The Child Records.

-Tree Traversal Concept Works on Node to Node Basis. We Can not Jump From One Node To Other Node Without Travelling The 
Between Records.

- We Can Eleminate ANY Terminal Nodes, But To Consider(To Reach) A Particular Terminal Node We Also Have to Consider All the Between Nodes.

- START WITH ,CONNECT BY and PRIOR Clause Are Applicable Only In Hierarchical Queries.

Pseudo Column:
--------------
-Pseudo Columns In Oracle Are The Columns That Are Not Part Of The Actual Table And Is Not Stored In The MetaData Of The Actual Tables.

- They Belong To Some Particular User And Are Shared With Every Other Users.

-The Major Pseudo Columns That Oracle Provides For The Application Development Purpose Are As Belows:
	-NEXTVAL 
	-CURRVAL
	-LEVEL 
	-ROWNUM
	-ROWID
	-CONNECT_BY_ISCYCLE
	-CONNECT_BY_ISLEAF

-The NEXTVAL & CURRVAL Pseudo Columns Are Only Used In Association With Sequence Objects.

-SEQUENCE Object Is Used to Generate Numeric Unique Keys(Sequential/Random) For Primary Key Columns Or Any Other Column Which Are Unique By Their Nature.

-LEVEL 
	-The LEVEL Pseudo Columns Is a Wonderful Component That Gives Great Amount Of Advantage In Making So Critical Analysis Of the Data.

	-The Job Of the LEVEL Pseudo Column Is To See The Hierarchical Data Is Loaded With The Corresponding Generation Number. It Gives the Level Number Of The Elements In Which They Are Present.

	-Generally the ROOT Element Where It Starts Is Given With Level Number 1 And From There As The Generation Is Changing The LEVEL Number Also Will Change.

	- LEVEL Operator Demands The Query To Be Hierarchical By Nature To Operate On It.

	-Using LEVEL Number We Can Query The Data In Hierarchy Without Knowing Anything Extra Information About The Hierarchical Data, Because It Directly Gives The Value Representing The Generation Number.


		SELECT LEVEL,Ename,Empno,Job,Sale
		FROM Emp
		START WITH Ename='KING'
		CONNECT BY PRIOR Empno=MGR;
		
		SELECT LEVEL,Ename,Empno,Job,Sale
		FROM Emp
		START WITH Ename='KING'
		CONNECT BY PRIOR Empno=MGR
		ORDER BY LEVEL ASC;
		
		SELECT LEVEL,Ename,Empno,Job,Sale
		FROM Emp
		START WITH Ename='KING'
		CONNECT BY PRIOR Empno=MGR;
		ORDER BY LEVEL DESC;
		
		SELECT LPAD(LEVEL,(2*LEVEL)-1) OrgChart||'.'||Ename,Empno,Job,Sale
		FROM Emp
		START WITH Ename='KING'
		CONNECT BY PRIOR Empno=MGR
		ORDER BY OrgChart ASC;
		
		SELECT LPAD(LEVEL,(2*LEVEL)-1) OrgChart||'.'||Ename,Empno,Job,Sale
		FROM Emp
		START WITH Ename='KING'
		CONNECT BY PRIOR Empno=MGR
		ORDER BY OrgChart DESC;
		
		SELECT LPAD(LEVEL,(2*LEVEL)-1) OrgChart||'.'||Ename,Empno,Job,Sale
		FROM Emp
		START WITH Ename='KING'
		CONNECT BY PRIOR Empno=MGR AND LEVEL<=2;
		
		SELECT LPAD(LEVEL,(2*LEVEL)-1) OrgChart||'.'||Ename,Empno,Job,Sale
		FROM Emp
		WHERE LEVEL=2
		START WITH Ename='KING'
		CONNECT BY PRIOR Empno=MGR;		


-ROWNUM
  - Oracle Assigns A Unique Row Number For Each Row That Is Selected By The Query. This Number is Represented By A Special Pseudo Column Call ROWNUM.
  - This ROWNUM Is Dynamically Generated And Assigned To Each Row. 
  - This Number  Will Change From Buffer to Buffer. This Number Is Not Arranged As Per The Ordering Of ORDER By Clause.
  - This Pseudo Column Help Us In Limiting The Rows.
  - When This Pseudo Columnn Is Applied WIth WHERE Clause, For any condition > = Any Positive Integer Returns False.
  - Within The Internal Architecture Of Oracle ,the ROWNUM Value is Always 1.
  - When a Record Is Selected, ROWNUM Value Will be Assigned To The Record By Incrementing That Percticular Value.
  - Oracle Maintains One More Internal Variable Called CURRENT_ROW_NUMBER.
  - The Default value Of CURRENT_ROW_NUMBER Is Always 0.
  - When A Record Is Selected The ROWNUM Values allocates Its Value For the Sake Of Incrementing its Value.But ROWNUM Value Will not Change.
  
-ROWID
	-ROWID Pseudo Column Represents The Physical Address Of The Record In The HardDisk.
	-Every Records Has 3 Types Of Address i.e. 1.File address 2.Block address 3.Record Address.
	-ROWID Referes to All The Above 3 Types of Address.
	-ROW Id is Permanent Thoroughout the Lifetime Of That Record.
	-ROWID Is Created While Data Is Inserted Into The Table And This Address Wont Change.


-CONNECT_BY_ISCYCLE
	- Useful In Identifying Exactly Where The Cycle Problem Arising In The Hierarchy.
	- Cycle Problem Occures When The Child Node Is Acting As a Parent To Its Parent Node.
	
-CONNECT_BY_ISLEAF
	- Useful In Identifying All The Child Nodes And Parent Nodes. 
	- It Returns 0 If the Record Is Parent. and Retuns 1 If the Record is a Leaf Node.
	




	
	
	
	-- Get the details of the Job having least average investment
-- Get the details of all the employees who are earning least investment in the Organization.
-- Get the details  of all the emmployee who is earning equal to the investments on TURNER.
--Get the details of all the employee who are earning more than the investments of CLERKs.
--Get the details of all the employee who are earning more than the highest invested CLERK.
--Get the details of all the employees who are earning more than the minimum investments in SALES department.
--Get the details of all employee who are earning more than the  least investments of department 30
--Get the details of all the employee who are earning more than the minimum investments of the departments.
--Get the details of all the employees who are earning below the minimum investments in SALES department other than CLERK Designation.
--Get the details of all the employee who are earning below the highest invested CLERK.
--Get the details of all the employee who are earning below the investments of CLERKs.
--Get the details of the employees who are earning below the highest of the lowest investments in SALES department.
--Get the details of all employee who are earning below the highest of the least investments of departments
--Get the details of all the employee who are earning below the minimum investments of the department.
-- Get the details of all the employee who are earning equal to least investment of the department.
-- Get the details of all the department who are earning equal to the investment on SALES department employees recuirtment date
-- Get the details of all the employees who are earning equal to the investment on department 20 employees hiredate.
Get the details of all the employees who are earning equal to least salaries of the departments.
Get the details of all the employees who are earning to the highest investments of the departments.
Get the details of all the employees who are earning equal to the highest investments on designations.
Get the details of all the employees who are earning equal to the lowest investments on designations.
Get the details of all the employees who are earning equal to the average investments on designations.

Get all the employees who are earning equal to the investments on department 20 employees recruitment date.
Get all the employees who are earning equal to the investments on SALES department employees recruitment date.


Get the detail of all the employee who are earning more than maximum investments in the departments;


SELECT * 
FROM Emp
WHERE Sal > ANY
	(
	 SELECT MIN(Sal)
	 FROM Emp
	 GROUP BY Deptno
	);

 	
	
	
	
	SELECT Empno,Ename,Job,Sal
FROM Emp
WHERE Sal =
	(
	SEELCT MAX(Sal)
	FROM Emp
	WHERE Deptno=
			(
			SELECT Deptno
			FROM Dept
			WHERE Dname='SALES'
			)
	)
	
Get the highest paid employee in the organization.
Get the highest paid employee information working for department 30.
Get the highest paid employee information working for Sales Department.
Get the Department wise Least investment Only when the departments investment is more than the minimum investment of the Org.
Calculate Least investments on the departments only when the least investment crosses w.r.t department 20. 
Whenever we write a subquery within the HAVING clause the outer query should follow all the rules related to the GROUP Functions and the GROUP By Clause.






Write a PL/SQL Program For the Following Requirement:
	After the Payroll Is Decided. Every Employee Details Should be Moved to Their Department Table in their Department Server.

PayrollDept10
-------------
 Empno
 Ename
 Job
 HireDate
 WrkExp
 Basic
 Comm
 GrossSal
 
CREATE TABLE PayrollDept10
AS 
SELECT Empno,Ename,Job,MGR,Sal,TRUNC(MONTHS_BETWEEN(HireDate,SYSDATE)/12) WrkExp,Sal+NVL(Comm,0) GrossSal,Comm
FROM Emp
WHERE 1=2;
 
PayrollDept20
CREATE TABLE PayrollDept20
AS 
SELECT Empno,Ename,Job,MGR,Sal,TRUNC(MONTHS_BETWEEN(HireDate,SYSDATE)/12) WrkExp,Sal+NVL(Comm,0) GrossSal,Comm
FROM Emp
WHERE 1=2;

PayRollDept30
CREATE TABLE PayrollDept30
AS 
SELECT Empno,Ename,Job,MGR,Sal,TRUNC(MONTHS_BETWEEN(HireDate,SYSDATE)/12) WrkExp,Sal+NVL(Comm,0) GrossSal,Comm
FROM Emp
WHERE 1=2;

PayRollDept40
CREATE TABLE PayrollDept40
AS 
SELECT Empno,Ename,Job,MGR,Sal,TRUNC(MONTHS_BETWEEN(HireDate,SYSDATE)/12) WrkExp,Sal+NVL(Comm,0) GrossSal,Comm
FROM Emp
WHERE 1=2;


DECLARE
V_GrossSal Emp.Sal%TYPE;
V_WrkExp   NUMBER;
CURSOR EmpPayrollDetails
IS
SELECT Empno,Ename,Job,MGR,Sal,TRUNC(MONTHS_BETWEEN(HireDate,SYSDATE)/12) WrkExp,Sal+NVL(Comm,0) GrossSal,Comm,Deptno
FROM Emp
ORDER BY Deptno;
EmpPayrollRecord EmpPayrollDetails%TYPE;
V_PayrollStatusDept10 NUMBER;
V_PayrollStatusDept20 NUMBER;
V_PayrollStatusDept30 NUMBER;
V_PayrollStatusDept40 NUMBER;
BEGIN
	SELECT COUNT(*) INTO V_PayrollStatusDept10
	FROM PayrollDept10;
	IF V_PayrollStatusDept10 <>0 THEN
	DELETE FROM PayrollDept10;
	END IF;
	SELECT COUNT(*) INTO V_PayrollStatusDept20
	FROM PayrollDept20;
	IF V_PayrollStatusDept20 <>0 THEN
	DELETE FROM PayrollDept20;
	END IF;
	IF V_PayrollStatusDept30 <>0 THEN
	DELETE FROM PayrollDept30;
	END IF;
	IF V_PayrollStatusDept40 <>0 THEN
	DELETE FROM PayrollDept40;
	END IF;
	COMMIT;
    IF NOT EmpPayrollDetails%ISOPEN THEN
	OPEN EmpPayrollDetails;
	END IF;
	FETCH EmpPayrollDetails INTO EmpPayrollRecord;
	WHILE EmpPayrollDetails%FOUND
	LOOP 
	  IF EmpPayrollRecord.Deptno=10 THEN
	    V_GrossSal:=NVL(EmpPayrollRecord.Sal,0)+NVL(EmpPayrollRecord.Comm,0);
		V_WrkExp:=
	    INSERT INT
	  END IF;
	END LOOP;
END;	





DECLARE
V_Sal Emp.Sal%TYPE;
V_Emp Emp%ROWTYPE;
BEGIN
SELECT * INTO V_Emp
FROM Emp
WHERE Sal=V_Sal;
DBMS_OUTPUT.PUT_LINE('Ename:'||V_Emp.Ename||', '||'Job:'||V_Emp.Job);
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('No Employee Exist With this Salary.');
WHEN TOO_MANY_ROWS THEN
DBMS_OUTPUT.PUT_LINE('No Employee Exist With this Salary.');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('No Employee Exist With this Salary.');
END;

Predifned Exception Handels Provided By Oracle:
----------------------------------------------
NO_DATA_FOUND
 - This Handle Is Recognized When No Rows Found In PL/SQL.
TOO_MANY_ROWS
 - This Handle Is Recognized When Multiple Rows Are Selected In PL/SQL.
INVALID_NUMBER
 - This Handle Is Recognized When We Are Operating With Improper Number Format In SQL.
VALUE_ERROR
 - This Handle Is Recognized When We Are Operating With Improper Number Format In PL/SQL.
 - This Handle Is Also Useful When The Input Data Is More than the Size of the Variable that is declared.
DUP_VAL_ON_INDEX
 - This Handle Is Recognized When Primary Key Column Value Is Inserted With Duplicate Value Into Table.
CURSOR_ALREADY_OPEN 
 - This Handle is Recognized When Trying to Open the CURSOR If It is Already Open.
INVALID_CURSOR
 - This Handle Is Recognized When Trying to Close a CURSOR Multiple Times.
 - This Handle Is Also Helpful When Trying to Fetch The CURSOR Without Opening It.
CASE_NOT_FOUND
 - This Handle Is Recognized No Matching Situation Found With in a CASE Statement.
ZERO_DIVIDE
 - This Halndle Is Recognized Upon Trying to Divide a Number with 0 Value.
OTHERS
 - This Handle Is Helpful to Capture all Exception When We do not Know The Exact Category Of Exception Which May Raise.
 

- Trapping Non-Predefined Oracle Server Errors:
----------------------------------------------
PRAGMA is also Called as PSeudo Instruction.

EXCEPTION Is a Datatype in PL/SQL.

NotNull Violation -1400
ChekcCOnstraint   -2290
DeletingParentRecord While Child Record Exists.







BEGIN
DECLARE
V_Empno Emp.Empno%TYPE:=&empno;
V_Ename Emp.Ename%TYPE:=&ename;
V_Job   Emp.Job%TYPE:=&job;
V_MGR   Emp.MGR%TYPE:=&mgr;
V_HireDate Emp.HireDate%TYPE:=&hiredate;
V_Sal   Emp.Sal%TYPE:=&sal;
V_Comm  Emp.Comm%TYPE:=&comm;
V_Deptno Emp.Deptno%TYPE:=&deptno;	
	BEGIN
	CHECK_EMPNO(V_Empno);
	CHECK_JOB(V_Job);
	CHECK_MGR(V_MGR);
	CHECK_HIREDATE(V_HireDate);
	CHECK_DEPARTMENT(V_Deptno);
	
	EXCEPTION
	WHEN OTHERS THEN
	DBMS_OUTPUT.PUT_LINE('Error Occured While Inserting. Possible Reason Could be Validation Failure.');
	DBMS_OUTPUT.PUT_LINE('Server Error:'||SQLCODE||' Server Error Message:'||SQLERRM);
	END;
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('Error Occured While Processing. Possible Reason Could be Invalid Data Input.');
DBMS_OUTPUT.PUT_LINE('Server Error:'||SQLCODE||' Server Error Message:'||SQLERRM);
END;



CREATE OR REPLACE PROCEDURE CHECK_EMPNO(I_Empno Emp.Empno%TYPE)
DECLARE
V_Count NUMBER;
E_Emp_Alredy_Exists EXCEPTION;
BEGIN
 SELECT COUNT(*) INTO V_Count 
 FROM Emp
 WHERE Empno=I_Empno;
 IF V_Count<>0 THEN
 DBMS_OUTPUT.PUT_LINE('Employee Number Validation Success.');
 ELSE 
 RAISE_APPLICATION_ERROR(-20000,'Duplcicate Entry Found.');
 END IF;
EXCEPTION
WHEN OTHERS THAN
END;

CREATE OR REPLACE PROCEDURE CHECK_JOB(I_Empno Emp.Empno%TYPE)
DECLARE
V_Count NUMBER;
E_Emp_Alredy_Exists EXCEPTION;
BEGIN
 SELECT COUNT(*) INTO V_Count 
 FROM Emp
 WHERE Empno=I_Empno;
 IF V_Count<>0 THEN
 DBMS_OUTPUT.PUT_LINE('Employee Number Validation Success.');
 ELSE 
 RAISE_APPLICATION_ERROR(-20000,'Duplcicate Entry Found.');
 END IF;
EXCEPTION
WHEN OTHERS THAN
END;

