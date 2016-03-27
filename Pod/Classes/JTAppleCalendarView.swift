//
//  JTAppleCalendarView.swift
//  JTAppleCalendar
//
//  Created by Jay Thomas on 2016-03-01.
//  Copyright © 2016 OS-Tech. All rights reserved.
//

let cellReuseIdentifier = "JTDayCell"

let NUMBER_OF_DAYS_IN_WEEK = 7

let MAX_NUMBER_OF_DAYS_IN_WEEK = 7                              // Should not be changed
let MIN_NUMBER_OF_DAYS_IN_WEEK = MAX_NUMBER_OF_DAYS_IN_WEEK     // Should not be changed
let MAX_NUMBER_OF_ROWS_PER_MONTH = 6                            // Should not be changed
let MIN_NUMBER_OF_ROWS_PER_MONTH = 1                            // Should not be changed

let FIRST_DAY_INDEX = 0
let OFFSET_CALC = 2
let NUMBER_OF_DAYS_INDEX = 1
let DATE_SELECTED_INDEX = 2
let TOTAL_DAYS_IN_MONTH = 3
let DATE_BOUNDRY = 4

/// Describes which month the cell belongs to
/// - ThisMonth: Cell belongs to the current month
/// - PreviousMonthWithinBoundary: Cell belongs to the previous month. Previous month is included in the date boundary you have set in your delegate
/// - PreviousMonthOutsideBoundary: Cell belongs to the previous month. Previous month is not included in the date boundary you have set in your delegate
/// - FollowingMonthWithinBoundary: Cell belongs to the following month. Following month is included in the date boundary you have set in your delegate
/// - FollowingMonthOutsideBoundary: Cell belongs to the following month. Following month is not included in the date boundary you have set in your delegate
///
/// You can use these cell states to configure how you want your date cells to look. Eg. you can have the colors belonging to the month be in color black, while the colors of previous months be in color gray.
public struct CellState {
    public enum DateOwner: Int {
        case ThisMonth = 0, PreviousMonthWithinBoundary, PreviousMonthOutsideBoundary, FollowingMonthWithinBoundary, FollowingMonthOutsideBoundary
    }
    public let isSelected: Bool
    public let text: String
    public let dateBelongsTo: DateOwner
}

/// Days of the week
public enum DaysOfWeek: Int {
    case Sunday = 7, Monday = 6, Tuesday = 5, Wednesday = 4, Thursday = 10, Friday = 9, Saturday = 8
}

public protocol JTAppleCalendarViewDataSource {
    /// Asks the data source to return the start and end boundary dates as well as the calendar to use. You should properly configure your calendar at this point.
    /// - Parameters:
    ///     - calendar: The JTAppleCalendar view requesting this information.
    /// - returns:
    ///     - startDate: The *start* boundary date for your calendarView.
    ///     - endDate: The *end* boundary date for your calendarView.
    ///     - calendar: The *calendar* to be used by the calendarView.
    func configureCalendar(calendar: JTAppleCalendarView) -> (startDate: NSDate, endDate: NSDate, calendar: NSCalendar)
}

public protocol JTAppleCalendarViewDelegate {
    /// Asks the delegate if selecting the date-cell with a specified date is allowed
    /// - Parameters:
    ///     - calendar: The JTAppleCalendar view requesting this information.
    ///     - date: The date attached to the date-cell.
    ///     - cell: The date-cell view. This can be customized at this point.
    ///     - cellState: The month the date-cell belongs to.
    /// - returns:
    ///     - A Bool value indicating if the operation can be done.
    func calendar(calendar : JTAppleCalendarView, canSelectDate date : NSDate, cell: JTAppleDayCellView, cellState: CellState) -> Bool
    
    /// Asks the delegate if de-selecting the date-cell with a specified date is allowed
    /// - Parameters:
    ///     - calendar: The JTAppleCalendar view requesting this information.
    ///     - date: The date attached to the date-cell.
    ///     - cell: The date-cell view. This can be customized at this point.
    ///     - cellState: The month the date-cell belongs to.
    /// - returns:
    ///     - A Bool value indicating if the operation can be done.
    func calendar(calendar : JTAppleCalendarView, canDeselectDate date : NSDate, cell: JTAppleDayCellView, cellState: CellState) -> Bool
    
    /// Tells the delegate that a date-cell with a specified date was selected
    /// - Parameters:
    ///     - calendar: The JTAppleCalendar view giving this information.
    ///     - date: The date attached to the date-cell.
    ///     - cell: The date-cell view. This can be customized at this point.
    ///     - cellState: The month the date-cell belongs to.
    func calendar(calendar : JTAppleCalendarView, didSelectDate date : NSDate, cell: JTAppleDayCellView, cellState: CellState) -> Void
    
    /// Tells the delegate that a date-cell with a specified date was de-selected
    /// - Parameters:
    ///     - calendar: The JTAppleCalendar view giving this information.
    ///     - date: The date attached to the date-cell.
    ///     - cell: The date-cell view. This can be customized at this point.
    ///     - cellState: The month the date-cell belongs to.
    func calendar(calendar : JTAppleCalendarView, didDeselectDate date : NSDate, cell: JTAppleDayCellView?, cellState: CellState) -> Void
    
    /// Tells the delegate that the JTAppleCalendar view scrolled to a segment beginning and ending with a particular date
    /// - Parameters:
    ///     - calendar: The JTAppleCalendar view giving this information.
    ///     - date: The date at the start of the segment.
    ///     - cell: The date at the end of the segment.
    func calendar(calendar : JTAppleCalendarView, didScrollToDateSegmentStartingWith date: NSDate?, endingWithDate: NSDate?) -> Void
    
    /// Tells the delegate that the JTAppleCalendar is about to display a date-cell. This is the point of customization for your date cells
    /// - Parameters:
    ///     - calendar: The JTAppleCalendar view giving this information.
    ///     - cell: The date-cell that is about to be displayed.
    ///     - date: The date attached to the cell.
    ///     - cellState: The month the date-cell belongs to.
    func calendar(calendar : JTAppleCalendarView, isAboutToDisplayCell cell: JTAppleDayCellView, date:NSDate, cellState: CellState) -> Void
}

public extension JTAppleCalendarViewDelegate {
    func calendar(calendar : JTAppleCalendarView, canSelectDate date : NSDate, cell: JTAppleDayCellView, cellState: CellState)->Bool {return true}
    func calendar(calendar : JTAppleCalendarView, canDeselectDate date : NSDate, cell: JTAppleDayCellView, cellState: CellState)->Bool {return true}
    func calendar(calendar : JTAppleCalendarView, didSelectDate date : NSDate, cell: JTAppleDayCellView, cellState: CellState) {}
    func calendar(calendar : JTAppleCalendarView, didDeselectDate date : NSDate, cell: JTAppleDayCellView?, cellState: CellState) {}
    func calendar(calendar : JTAppleCalendarView, didScrollToDateSegmentStartingWith date: NSDate?, endingWithDate: NSDate?) {}
    func calendar(calendar : JTAppleCalendarView, isAboutToDisplayCell cell: JTAppleDayCellView, date:NSDate, cellState: CellState) {}
}


public class JTAppleCalendarView: UIView {
    /// The amount of buffer space before the first row of date-cells
    public var bufferTop: CGFloat    = 0.0
    /// The amount of buffer space after the last row of date-cells
    public var bufferBottom: CGFloat = 0.0
    /// Enables and disables animations when scrolling to and from date-cells
    public var animationsEnabled = true
    /// The scroll direction of the sections in JTAppleCalendar.
    public var direction : UICollectionViewScrollDirection = .Horizontal {
        didSet {
            if let layout = self.calendarView.collectionViewLayout as? JTAppleCalendarFlowLayout {
                layout.scrollDirection = direction
                self.calendarView.reloadData()
            }
        }
    }
    /// Enables/Disables multiple selection on JTAppleCalendar
    public var allowsMultipleSelection: Bool = false {
        didSet {
            self.calendarView.allowsMultipleSelection = allowsMultipleSelection
        }
    }
    /// First day of the week value for JTApleCalendar. You can set this to anyday
    public var firstDayOfWeek = DaysOfWeek.Sunday
    
    private var layoutNeedsUpdating = false
    /// Number of rows to be displayed per month. Allowed values are 1, 2, 3 & 6
    public var numberOfRowsPerMonth = 6 {
        didSet {
            if numberOfRowsPerMonth == 4 || numberOfRowsPerMonth == 5 || numberOfRowsPerMonth > 6 || numberOfRowsPerMonth < 0 {numberOfRowsPerMonth = 6}
            if monthInfoActivated {
                layoutNeedsUpdating = true
            }
        }
    }
    /// The object that acts as the data source of the calendar view.
    public var dataSource : JTAppleCalendarViewDataSource?
    /// The object that acts as the delegate of the calendar view.
    public var delegate : JTAppleCalendarViewDelegate?
    
    private var scrollToDatePathOnRowChange: NSDate?
    private var delayedExecutionClosure: (()->Void)?
    private var currentSectionPage: Int {
        let cvbounds = self.calendarView.bounds
        var page : Int = 0
        if self.direction == .Horizontal {
            page = Int(floor(self.calendarView.contentOffset.x / cvbounds.size.width))
        } else {
            page = Int(floor(self.calendarView.contentOffset.y / cvbounds.size.height))
        }
        let totalSections = monthInfo.count * numberOfSectionsPerMonth
        if page >= totalSections {return totalSections - 1}
        return page > 0 ? page : 0
    }

    lazy private var startDateCache : NSDate? = {
       [weak self] in
        if let  dateBoundary = self!.dataSource?.configureCalendar(self!) {
                // Jt101 do a check in each lazy var to see if user has bad star/end dates
                self!.endDateCache = dateBoundary.endDate
                self!.calendar = dateBoundary.calendar
                return dateBoundary.startDate
            }
            return nil
    }()
    
    lazy private var endDateCache : NSDate? = {
        [weak self] in
            if let  dateBoundary = self!.dataSource?.configureCalendar(self!) {
                self!.startDateCache = dateBoundary.startDate
                self!.calendar = dateBoundary.calendar
                return dateBoundary.endDate

            }
            return nil
    }()
    
    lazy private var calendar : NSCalendar = {
       [weak self] in
        guard let  dateBoundary = self!.dataSource?.configureCalendar(self!)  else {
            self!.startDateCache = NSDate()
            self!.endDateCache = NSDate()
            return NSCalendar.currentCalendar()
        }
        
        self!.startDateCache = dateBoundary.startDate
        self!.endDateCache = dateBoundary.endDate
        return dateBoundary.calendar

    }()
    
    lazy private var startOfMonthCache : NSDate = {
        [weak self] in
        let dayOneComponents = self!.calendar.components([NSCalendarUnit.Era, NSCalendarUnit.Year, NSCalendarUnit.Month], fromDate: self!.startDateCache!)
        if let date = self!.calendar.dateFromComponents(dayOneComponents) {
            return date
        }
        let currentDate = NSDate()
        print("Error: Date was not correctly generated for start of month. current date was used: \(currentDate)")
        return currentDate
    }()
    
    lazy private var endOfMonthCache : NSDate = {
        [weak self] in
            // set last of month
            let lastDayComponents = self!.calendar.components([NSCalendarUnit.Era, NSCalendarUnit.Year, NSCalendarUnit.Month], fromDate: self!.endDateCache!)
            lastDayComponents.month = lastDayComponents.month + 1
            lastDayComponents.day = 0
        if let returnDate = self!.calendar.dateFromComponents(lastDayComponents) {
            return returnDate
        }
        let currentDate = NSDate()
        print("Error: Date was not correctly generated for end of month. current date was used: \(currentDate)")
        return currentDate
    }()
    
    
    private(set) var selectedIndexPaths : [NSIndexPath] = [NSIndexPath]()
    private(set) var selectedDates : [NSDate] = [NSDate]()

    private var monthInfoActivated = false
    lazy private var monthInfo : [[Int]] = {
        [weak self] in
            let newMonthInfo = self!.setupMonthInfoDataForStartAndEndDate()
            self!.monthInfoActivated = true
            return newMonthInfo
    }()

    
    private var numberOfMonthSections: Int = 0
    private var numberOfSectionsPerMonth: Int = 0
    private var numberOfItemsPerSection: Int {return MAX_NUMBER_OF_DAYS_IN_WEEK * numberOfRowsPerMonth}
    
    /// Cell inset padding for the x and y axis of every date-cell on the calendar view.
    public var cellInset: CGPoint {
        get {return internalCellInset}
        set {internalCellInset = newValue}
    }
    
    lazy private var calendarView : UICollectionView = {
     
        let layout = JTAppleCalendarFlowLayout()
        layout.scrollDirection = self.direction;
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let cv = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.pagingEnabled = true
        cv.backgroundColor = UIColor.clearColor()
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.allowsMultipleSelection = false
        return cv
        
    }()
    
    override public var frame: CGRect {
        didSet {
            self.calendarView.frame = CGRect(x:0.0, y:bufferTop, width: self.frame.size.width, height:self.frame.size.height - bufferBottom)
            self.calendarView.collectionViewLayout = self.calendarView.collectionViewLayout as! JTAppleCalendarFlowLayout // Needed?
            
            let layout = self.calendarView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.itemSize = CGSizeMake(
                self.calendarView.frame.size.width / CGFloat(MAX_NUMBER_OF_DAYS_IN_WEEK),
                (self.calendarView.frame.size.height - layout.headerReferenceSize.height) / CGFloat(numberOfRowsPerMonth))
            calendarView.collectionViewLayout = layout
        }
    }

    override init(frame: CGRect) {
        super.init(frame : CGRectMake(0.0, 0.0, 200.0, 200.0))
        self.initialSetup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func awakeFromNib() {
        self.initialSetup()
    }
    
    override public func layoutSubviews() {
        self.frame = super.frame
    }
        
    // MARK: Setup
    func initialSetup() {
        self.clipsToBounds = true
        self.calendarView.registerClass(JTAppleDayCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        self.addSubview(self.calendarView)
    }
    
    /// Let's the calendar know which cell xib to use for the displaying of it's date-cells.
    /// - Parameter name: The name of the xib of your cell design
    public func registerCellViewXib(fileName name: String) {
        cellViewXibName = name
    }
    
    
    // MARK: functions
    
    /// Reloads the data on the calendar view
    public func reloadData() {
        if layoutNeedsUpdating {
            changeNumberOfRowsPerMonthTo(numberOfRowsPerMonth, withFocusDate: nil)
            layoutNeedsUpdating = false
        } else {
            self.calendarView.reloadData()
        }
    }
    
    /// Change the number of rows per month on the calendar view. Once the row count is changed, the calendar view will auto-focus on tht date provided.
    /// - Parameter number: The number of rows per month the calendar view should display. This is restricted to 1, 2, 3, & 6. 6 will be chosen as default.
    public func changeNumberOfRowsPerMonthTo(number: Int, withFocusDate date: NSDate?) {
        switch number {
            case 1, 2, 3, 6:
                scrollToDatePathOnRowChange = date
                numberOfRowsPerMonth = number
                configureChangeOfRows()
            
            default:
//                print("Months 4 and 5 are not allowed. Experimental at this point. Setting is not allowed.")
                scrollToDatePathOnRowChange = date
                numberOfRowsPerMonth = 6
                configureChangeOfRows()
        }
    }
    
    private func configureChangeOfRows () {
        selectedDates.removeAll()
        selectedIndexPaths.removeAll()
        
        monthInfo = setupMonthInfoDataForStartAndEndDate()
        monthInfoActivated = true
        
        self.calendarView.reloadData()
        let position: UICollectionViewScrollPosition = self.direction == .Horizontal ? .Left : .Top
        guard let dateToScrollTo = scrollToDatePathOnRowChange else {
            // If the date is invalid just scroll to the the first item on the view
            calendarView.scrollToItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 0), atScrollPosition: position, animated: animationsEnabled)
            return
        }
        
        delayRunOnMainThread(0.1, closure: { () -> () in
            self.scrollToDate(dateToScrollTo)
        })
    }
    
    private func setupMonthInfoDataForStartAndEndDate()-> [[Int]] {

        var retval: [[Int]] = []
        
        if let  dateBoundary = dataSource?.configureCalendar {
            let startDate = dateBoundary(self).startDate,
            endDate = dateBoundary(self).endDate
            
            // check if the dates are in correct order
            if calendar.compareDate(startDate, toDate: endDate, toUnitGranularity: NSCalendarUnit.Nanosecond) == NSComparisonResult.OrderedDescending {
                print("No dates can be generated because your start date is greater than your end date.")
                return retval
            }
            
            startDateCache = startDate
            endDateCache = endDate
            
                
            // discard day and minutes so that they round off to the first of the month
            let dayOneComponents = calendar.components(
                [NSCalendarUnit.Era, NSCalendarUnit.Year, NSCalendarUnit.Month],
                fromDate: startDateCache!
            )
            
            // set last of month
            let lastDayComponents = calendar.components([NSCalendarUnit.Era, NSCalendarUnit.Year, NSCalendarUnit.Month], fromDate: endDateCache!)
            lastDayComponents.month = lastDayComponents.month + 1
            lastDayComponents.day = 0
            
            if let 
                dateFromDayOneComponents = calendar.dateFromComponents(dayOneComponents),
                dateFromLastDayComponents =  calendar.dateFromComponents(lastDayComponents) {
                startOfMonthCache = dateFromDayOneComponents
                endOfMonthCache = dateFromLastDayComponents

                let differenceComponents = calendar.components(
                    NSCalendarUnit.Month,
                    fromDate: startOfMonthCache,
                    toDate: endOfMonthCache,
                    options: []
                )
                
                // Create boundary date
                let leftDate = calendar.dateByAddingUnit(.Weekday, value: -1, toDate: startOfMonthCache, options: [])!
                let leftDateInt = calendar.component(.Day, fromDate: leftDate)
                
                // Number of months
                numberOfMonthSections = differenceComponents.month + 1 // if we are for example on the same month and the difference is 0 we still need 1 to display it
                
                // Number of sections in each month
                numberOfSectionsPerMonth = Int(ceil(Float(MAX_NUMBER_OF_ROWS_PER_MONTH)  / Float(numberOfRowsPerMonth)))
                
                
                // Section represents # of months. section is used as an offset to determine which month to calculate
                for numberOfMonthsIndex in 0 ... numberOfMonthSections - 1 {
                    if let correctMonthForSectionDate = calendar.dateByAddingUnit(.Month, value: numberOfMonthsIndex, toDate: startOfMonthCache, options: []) {
                        
                        let numberOfDaysInMonth = calendar.rangeOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Month, forDate: correctMonthForSectionDate).length
                        
                        var firstWeekdayOfMonthIndex = calendar.component(.Weekday, fromDate: correctMonthForSectionDate)
                        firstWeekdayOfMonthIndex -= 1 // firstWeekdayOfMonthIndex should be 0-Indexed
                        firstWeekdayOfMonthIndex = (firstWeekdayOfMonthIndex + firstDayOfWeek.rawValue) % 7 // push it modularly so that we take it back one day so that the first day is Monday instead of Sunday which is the default
                        
                        
                        // We have number of days in month, now lets see how these days will be allotted into the number of sections in the month
                        // We will add the first segment manually to handle the fdIndex inset
                        let aFullSection = (numberOfRowsPerMonth * MAX_NUMBER_OF_DAYS_IN_WEEK)
                        var numberOfDaysInFirstSection = aFullSection - firstWeekdayOfMonthIndex
                        
                        // If the number of days in first section is greater that the days of the month, then use days of month instead
                        if numberOfDaysInFirstSection > numberOfDaysInMonth {
                            numberOfDaysInFirstSection = numberOfDaysInMonth
                        }
                        
                        let firstSectionDetail: [Int] = [firstWeekdayOfMonthIndex, numberOfDaysInFirstSection, 0, numberOfDaysInMonth] //fdIndex, numberofDaysInMonth, offset
                        retval.append(firstSectionDetail)
                        let numberOfSectionsLeft = numberOfSectionsPerMonth - 1
                        
                        // Continue adding other segment details in loop
                        if numberOfSectionsLeft < 1 {continue} // Continue if there are no more sections

                        var numberOfDaysLeft = numberOfDaysInMonth - numberOfDaysInFirstSection
                        for _ in 0 ... numberOfSectionsLeft - 1 {
                            switch numberOfDaysLeft {
                                case _ where numberOfDaysLeft <= aFullSection: // Partial rows
                                    let midSectionDetail: [Int] = [0, numberOfDaysLeft, firstWeekdayOfMonthIndex]
                                    retval.append(midSectionDetail)
                                    numberOfDaysLeft = 0
                                case _ where numberOfDaysLeft > aFullSection: // Full Rows
                                    let lastPopulatedSectionDetail: [Int] = [0, aFullSection, firstWeekdayOfMonthIndex]
                                    retval.append(lastPopulatedSectionDetail)
                                    numberOfDaysLeft -= aFullSection
                            default:
                                break
                            }
                        }
                    }
                }
                retval[0].append(leftDateInt)
            }
        }
        return retval
    }

    /// Scrolls the calendar view to the next section view. It will execute a completion handler at the end of scroll animation if provided.
    /// - Paramater animateScroll: Bool indicating if animation should be enabled
    /// - Parameter completionHandler: A completion handler that will be executed at the end of the scroll animation
    public func scrollToNextSegment(animateScroll: Bool = true, completionHandler:(()->Void)? = nil) {
        let page = currentSectionPage
        if page + 1 < monthInfo.count {
            let position: UICollectionViewScrollPosition = self.direction == .Horizontal ? .Left : .Top
            calendarView.scrollToItemAtIndexPath(NSIndexPath(forItem: 0, inSection:page + 1), atScrollPosition: position, animated: animateScroll)
        }
    }
    /// Scrolls the calendar view to the previous section view. It will execute a completion handler at the end of scroll animation if provided.
    /// - Paramater animateScroll: Bool indicating if animation should be enabled
    /// - Parameter completionHandler: A completion handler that will be executed at the end of the scroll animation
    public func scrollToPreviousSegment(animateScroll: Bool = true, completionHandler:(()->Void)? = nil) {
        let page = currentSectionPage
        if page - 1 > -1 {
            let position: UICollectionViewScrollPosition = self.direction == .Horizontal ? .Left : .Top
            calendarView.scrollToItemAtIndexPath(NSIndexPath(forItem: 0, inSection:page - 1), atScrollPosition: position, animated: animateScroll)
        }
    }
    
    private func xibFileValid() -> Bool {
        guard let xibName =  cellViewXibName else {
//            print("Did you remember to register your xib file to JTAppleCalendarView? call the registerCellViewXib method on it because xib filename is nil")
            return false
        }
        guard let viewObject = NSBundle.mainBundle().loadNibNamed(xibName, owner: self, options: [:]) where viewObject.count > 0 else {
//            print("your nib file name \(cellViewXibName) could not be loaded)")
            return false
        }
        
        guard let _ = viewObject[0] as? JTAppleDayCellView else {
//            print("xib file class does not conform to the protocol<JTAppleDayCellViewProtocol>")
            return false
        }
        
        return true
    }
    /// Scrolls the calendar view to the start of a section view containing a specified date.
    /// - Paramater date: The calendar view will scroll to a date-cell containing this date if it exists
    /// - Paramater animateScroll: Bool indicating if animation should be enabled
    /// - Parameter completionHandler: A completion handler that will be executed at the end of the scroll animation
    public func scrollToDate(date: NSDate, animateScroll: Bool = true, completionHandler:(()->Void)? = nil) {
        if !monthInfoActivated {
            return
        }
        
        let components = calendar.components([.Year, .Month, .Day],  fromDate: date)
        let firstDayOfDate = calendar.dateFromComponents(components)
        
        if !firstDayOfDate!.isWithinInclusiveBoundaryDates(startOfMonthCache, endDate: endOfMonthCache) {
            return
        }

        let periodApart = calendar.components(.Month, fromDate: startOfMonthCache, toDate: date, options: [])
        let monthsApart = periodApart.month
        let segmentIndex = monthsApart * numberOfSectionsPerMonth
        let sectionIndexPath =  pathsFromDates([date])[0]
        let page = currentSectionPage
        
        delayedExecutionClosure = completionHandler
        
        let segmentToScrollTo = NSIndexPath(forItem: 0, inSection: sectionIndexPath.section)
        
        if page != segmentIndex {
            let position: UICollectionViewScrollPosition = self.direction == .Horizontal ? .Left : .Top
            delayRunOnMainThread(0.0, closure: { 
                self.calendarView.scrollToItemAtIndexPath(segmentToScrollTo, atScrollPosition: position, animated: animateScroll)
                if  !animateScroll {
                    self.scrollViewDidEndScrollingAnimation(self.calendarView)
                }
            })
        } else {
            scrollViewDidEndScrollingAnimation(calendarView)
        }
    }
    
    /// Select a date-cell if it is on screen
    /// - Parameter date: The date-cell with this date will be selected
    public func selectDate(date: NSDate) {
        delayRunOnMainThread(0.0) { 
            let components = self.calendar.components([.Year, .Month, .Day],  fromDate: date)
            let firstDayOfDate = self.calendar.dateFromComponents(components)
            if !firstDayOfDate!.isWithinInclusiveBoundaryDates(self.startOfMonthCache, endDate: self.endOfMonthCache) {
                return
            }
            
            let periodApart = self.calendar.components(.Month, fromDate: self.startOfMonthCache, toDate: date, options: [])
            let segmentIndex = periodApart.month
            let sectionIndexPath =  self.pathsFromDates([date])[0]
            let page = self.currentSectionPage
            
            
            if page != segmentIndex {
                return // Incorrect section
            }
            self.calendarView.selectItemAtIndexPath(sectionIndexPath, animated: false, scrollPosition: .None)
            
            // Handle selection
            if self.calendarView.allowsMultipleSelection == false {
                for indexPath in self.selectedIndexPaths {
                    self.calendarView.deselectItemAtIndexPath(indexPath, animated: false)
                    self.collectionView(self.calendarView, didDeselectItemAtIndexPath: indexPath)
                }
            }
            self.collectionView(self.calendarView, didSelectItemAtIndexPath: sectionIndexPath)
        }

    }
    
    /// Reload the date of specified date-cells on the calendar-view
    /// - Parameter dates: Date-cells with these specified dates will be reloaded
    public func reloadDates(dates: [NSDate]) {
        let paths = pathsFromDates(dates)
        if paths.count > 0 {
            calendarView.reloadItemsAtIndexPaths(paths)
        }
    }
    
    private func pathsFromDates(dates:[NSDate])-> [NSIndexPath] {
        var returnPaths: [NSIndexPath] = []

        for date in dates {
            if date.isWithinInclusiveBoundaryDates(startOfMonthCache, endDate: endOfMonthCache) {
                let periodApart = calendar.components(.Month, fromDate: startOfMonthCache, toDate: date, options: [])
                let monthSectionIndex = periodApart.month
                let startSectionIndex = monthSectionIndex * numberOfSectionsPerMonth
                let sectionIndex = startMonthSectionForSection(startSectionIndex) // Get the section within the month

                // Get the section Information
                let currentMonthInfo = monthInfo[sectionIndex]
                let dayIndex = calendar.components(.Day, fromDate: date).day
                
                // Given the following, find the index Path
                let fdIndex = currentMonthInfo[FIRST_DAY_INDEX]
                let cellIndex = dayIndex + fdIndex - 1
                
                let updatedSection = cellIndex / numberOfItemsPerSection
                let adjustedSection = sectionIndex + updatedSection
                let adjustedCellIndex = cellIndex - (numberOfItemsPerSection * (cellIndex / numberOfItemsPerSection))
                returnPaths.append(NSIndexPath(forItem: adjustedCellIndex, inSection: adjustedSection))
            }
        }
        return returnPaths
    }

}

// MARK: scrollViewDelegates
extension JTAppleCalendarView: UIScrollViewDelegate {
    
    private func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        scrollViewDidEndDecelerating(scrollView)
        delayedExecutionClosure?()
        delayedExecutionClosure = nil
    }
    
    private func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        // Determing the section from the scrollView direction
        let section = currentSectionPage
        
        // When ever the month/section is switched, let the flowlayout know which page it is on. This is needed in the event user switches orientatoin, we can use the index to snap back to correct position
        (calendarView.collectionViewLayout as! JTAppleCalendarFlowLayout).pathForFocusItem = NSIndexPath(forItem: 0, inSection: section)
        
        let monthData = monthInfo[section]

        let itemLength = monthData[NUMBER_OF_DAYS_INDEX]

        let fdIndex = monthData[FIRST_DAY_INDEX]
        
        let startIndex = NSIndexPath(forItem: fdIndex, inSection: section)
        let endIndex = NSIndexPath(forItem: fdIndex + itemLength - 1, inSection: section)
        
        if let startDate = dateFromPath(startIndex), endDate = dateFromPath(endIndex) {
            self.delegate?.calendar(self, didScrollToDateSegmentStartingWith: startDate, endingWithDate: endDate)
        }
    }
}

extension JTAppleCalendarView {
    private func cellStateFromIndexPath(indexPath: NSIndexPath)->CellState {

        let itemIndex = indexPath.item
        let itemSection = indexPath.section
        
        let currentMonthInfo = monthInfo[itemSection] // we are guaranteed an array by the fact that we reached this line (so unwrap)
        
        let fdIndex = currentMonthInfo[FIRST_DAY_INDEX]
        let nDays = currentMonthInfo[NUMBER_OF_DAYS_INDEX]
        let offSet = currentMonthInfo[OFFSET_CALC]


        var cellText: String = ""
        var dateBelongsTo: CellState.DateOwner  = .ThisMonth
        
        
        if itemIndex >= fdIndex && itemIndex < fdIndex + nDays {
            let cellDate = (numberOfRowsPerMonth * MAX_NUMBER_OF_DAYS_IN_WEEK * (itemSection % numberOfSectionsPerMonth)) + itemIndex - fdIndex - offSet + 1
            cellText = String(cellDate)
            dateBelongsTo = .ThisMonth
        } else if
            itemIndex < fdIndex  &&
            itemSection - 1 > -1  { // Prior month is available
                let startOfMonthSection = startMonthSectionForSection(itemSection - 1)
                let cellDate = (numberOfRowsPerMonth * MAX_NUMBER_OF_DAYS_IN_WEEK * (itemSection % numberOfSectionsPerMonth)) + itemIndex - offSet + 1
                let dateToAdd = monthInfo[startOfMonthSection][TOTAL_DAYS_IN_MONTH]
                let dateInt = cellDate + dateToAdd - monthInfo[itemSection][FIRST_DAY_INDEX]
                cellText = String(dateInt)
                dateBelongsTo = .PreviousMonthWithinBoundary

        } else  if itemIndex >= fdIndex + nDays && itemSection + 1 < monthInfo.count { // Following months
            let startOfMonthSection = startMonthSectionForSection(itemSection)
            let cellDate = (numberOfRowsPerMonth * MAX_NUMBER_OF_DAYS_IN_WEEK * (itemSection % numberOfSectionsPerMonth)) + itemIndex - offSet + 1
            let dateToSubtract = monthInfo[startOfMonthSection][TOTAL_DAYS_IN_MONTH]
            let dateInt = cellDate - dateToSubtract - monthInfo[itemSection][FIRST_DAY_INDEX]
            cellText = String(dateInt)
            dateBelongsTo = .FollowingMonthWithinBoundary
        } else if itemIndex < fdIndex { // Pre from the start
            let cellDate = monthInfo[0][DATE_BOUNDRY] - monthInfo[0][FIRST_DAY_INDEX] + itemIndex + 1
            cellText = String(cellDate )
            dateBelongsTo = .PreviousMonthOutsideBoundary
        } else { // Post from the end
            let c = calendar.component(.Day, fromDate: dateFromPath(indexPath)!)
            cellText = String(c)
            dateBelongsTo = .FollowingMonthOutsideBoundary
        }

        let cellState = CellState(
            isSelected: selectedIndexPaths.contains(indexPath),
            text: cellText,
            dateBelongsTo: dateBelongsTo
        )
        
        return cellState
    }
    
    private func startMonthSectionForSection(aSection: Int)->Int {
        let monthIndexWeAreOn = aSection / numberOfSectionsPerMonth
        let nextSection = numberOfSectionsPerMonth * monthIndexWeAreOn
        return nextSection
    }
    
    private func dateFromPath(indexPath: NSIndexPath)-> NSDate? { // Returns nil if date is out of scope
        let itemIndex = indexPath.item
        let itemSection = indexPath.section
        let monthIndexWeAreOn = itemSection / numberOfSectionsPerMonth
        let currentMonthInfo = monthInfo[itemSection]
        let fdIndex = currentMonthInfo[FIRST_DAY_INDEX]
        let offSet = currentMonthInfo[OFFSET_CALC]
        let cellDate = (numberOfRowsPerMonth * MAX_NUMBER_OF_DAYS_IN_WEEK * (itemSection % numberOfSectionsPerMonth)) + itemIndex - fdIndex - offSet + 1
        let offsetComponents = NSDateComponents()
        
        offsetComponents.month = monthIndexWeAreOn
        offsetComponents.weekday = cellDate - 1

        return calendar.dateByAddingComponents(offsetComponents, toDate: startOfMonthCache, options: [])
    }
    
    private func delayRunOnMainThread(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    private func delayRunOnGlobalThread(delay:Double, qos: qos_class_t,closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ), dispatch_get_global_queue(qos, 0), closure)
    }
}

// MARK: CollectionView delegates
extension JTAppleCalendarView: UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let dayCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! JTAppleDayCell
        let cellState = cellStateFromIndexPath(indexPath)
        let date = dateFromPath(indexPath)!
        delegate?.calendar(self, isAboutToDisplayCell: dayCell.cellView, date: date, cellState: cellState)

        return dayCell
    }
    
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if !xibFileValid() {
            return 0
        }
        
        if monthInfo.count > 0 {
            self.scrollViewDidEndDecelerating(self.calendarView)
        }
        return monthInfo.count
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        let numberOfItemsInSection = MAX_NUMBER_OF_DAYS_IN_WEEK * numberOfRowsPerMonth
        return  numberOfItemsInSection// 7 x 6 = 42
    }
    
    public func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        if let
            dateUserSelected = dateFromPath(indexPath),
            delegate = self.delegate,
            cell = collectionView.cellForItemAtIndexPath(indexPath) as? JTAppleDayCell {
                if cell.cellView.hidden == false && cell.cellView.userInteractionEnabled == true{
                    let cellState = cellStateFromIndexPath(indexPath)
                    delegate.calendar(self, canSelectDate: dateUserSelected, cell: cell.cellView, cellState: cellState)
                    return true
                }
            }
        
        
        return false // if date is out of scope
    }
    
    public func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        if let
            delegate = self.delegate,
            index = selectedIndexPaths.indexOf(indexPath),
            dateSelectedByUser = dateFromPath(indexPath) {
    
                selectedIndexPaths.removeAtIndex(index)
                selectedDates.removeAtIndex(index)
                
                let selectedCell = collectionView.cellForItemAtIndexPath(indexPath) as? JTAppleDayCell // Cell may be nil if user switches month sections
                let cellState = cellStateFromIndexPath(indexPath) // Although the cell may be nil, we still want to return the cellstate
                delegate.calendar(self, didDeselectDate: dateSelectedByUser, cell: selectedCell?.cellView, cellState: cellState)
        }
    }
    
    public func collectionView(collectionView: UICollectionView, shouldDeselectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        if let
            dateUserSelected = dateFromPath(indexPath),
            delegate = self.delegate,
            cell = collectionView.cellForItemAtIndexPath(indexPath) as? JTAppleDayCell {
                let cellState = cellStateFromIndexPath(indexPath)
                delegate.calendar(self, canDeselectDate: dateUserSelected, cell: cell.cellView, cellState:  cellState)
                return true
        }
        return false
    }

    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let
            delegate = self.delegate, dateSelectedByUser = dateFromPath(indexPath),
            selectedCell = collectionView.cellForItemAtIndexPath(indexPath) as? JTAppleDayCell {
                
            // Update model
            if selectedIndexPaths.contains(indexPath) == false { // wrapping in IF statement handles both multiple select scenarios AND singleselection scenarios
                selectedIndexPaths.append(indexPath)
                selectedDates.append(dateSelectedByUser)
            }
            let cellState = cellStateFromIndexPath(indexPath)
            delegate.calendar(self, didSelectDate: dateSelectedByUser, cell: selectedCell.cellView, cellState: cellState)
        }
    }
}

private extension NSDate {
    private func isGreaterThanDate(dateToCompare: NSDate) -> Bool {
        if self.compare(dateToCompare) == .OrderedDescending {
            return true
        }
        return false
    }
    
    private func isLessThanDate(dateToCompare: NSDate) -> Bool {
        if self.compare(dateToCompare) == .OrderedAscending {
            return true
        }
        return false
    }
    
    private func equalToDate(dateToCompare: NSDate) -> Bool {
        if self.compare(dateToCompare) == .OrderedSame {
            return true
        }
        return false
    }
    
    private func isWithinInclusiveBoundaryDates(startDate: NSDate, endDate: NSDate)->Bool {
        if (self.equalToDate(startDate) || self.isGreaterThanDate(startDate)) && (self.equalToDate(endDate) || self.isLessThanDate(endDate)) {
            return true
        }
        return false
    }
    
    private func isWithinExclusiveBoundaryDates(startDate: NSDate, endDate: NSDate)->Bool {
        if self.isGreaterThanDate(startDate) && self.isLessThanDate(endDate) {
            return true
        }
        return false
    }
}
