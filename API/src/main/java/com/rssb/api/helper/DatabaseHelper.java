package com.rssb.api.helper;

import com.google.common.base.Strings;
import com.rssb.common.entity.*;
import com.rssb.common.helper.DBUtility;
import com.rssb.common.helper.Util;
import lombok.extern.slf4j.Slf4j;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import static com.rssb.api.QueryLib.*;
import static com.rssb.api.allocation.AllocationQuery.GET_ALLOCATED_PATHIS;
import static com.rssb.api.allocation.AllocationQuery.GET_ALLOCATED_PREACHER;
import static com.rssb.api.allocation.AllocationQuery.GET_ALLOCATION;
import static com.rssb.api.allocation.AllocationQuery.GET_ALLOCATION_BY_PREAHER;
import static com.rssb.api.allocation.AllocationQuery.INSERT_ALLOCATION;
import static com.rssb.api.allocation.AllocationQuery.UPDATE_CD_ALLOCATION;
import static com.rssb.api.allocation.AllocationQuery.UPDATE_CONT_ALLOCATION;
import static com.rssb.api.allocation.SgQuery.DEL_SATSANG_GHAR;
import static com.rssb.api.allocation.SgQuery.DEL_SCHEDULE;
import static com.rssb.api.allocation.SgQuery.GET_SATSANG_GHAR;
import static com.rssb.api.allocation.SgQuery.GET_SCHEDULE;
import static com.rssb.api.allocation.SgQuery.GET_SG_SEQ_ID;
import static com.rssb.api.allocation.SgQuery.INSERT_SCHEDULE;
import static com.rssb.api.allocation.AllocationQuery.*;

import static com.rssb.api.allocation.SgQuery.INSERT_SG;
import static com.rssb.api.allocation.SgQuery.UPDATE_SATSANG_GHAR;
import static com.rssb.api.allocation.AllocationQuery.INSERT_ATTENDANCE;

@Slf4j
public class DatabaseHelper {
	public DBUtility dbUtility;
	private static DatabaseHelper instance = null;

	private DatabaseHelper() {
		dbUtility = new DBUtility(DB.APP_DB);
	}

	public static DatabaseHelper getInstance() {
		if (null == instance)
			synchronized (DatabaseHelper.class) {
				if (null == instance)
					instance = new DatabaseHelper();
			}
		return instance;
	}

	public Long persisitSatsangGhar(SatsangGhar sg, List<Schedule> scheduleList) throws Exception {

		if (sg.getId() != null)
			return updateSG(sg, scheduleList);
		else
			return insertSG(sg, scheduleList);
	}

	public Long insertSG(SatsangGhar sg, List<Schedule> scheduleList) throws Exception {
		Long id = Long.parseLong(dbUtility.get(GET_SG_SEQ_ID));
		sg.setId(id);
		dbUtility.update(String.format(INSERT_SG, sg.getId(), sg.getName(), sg.getCenterType(), sg.getParentCenterid(),
				sg.getAddress1(), sg.getAddress2(), sg.getCity(), sg.getState(), sg.getPinCode(), sg.getMap(),
				sg.getLandline1(), sg.getLandline2(), sg.getMobile1(), sg.getMobile2(), sg.getSecName(),
				sg.getSecMobile()));
		for (Schedule schedule : scheduleList) {
			dbUtility.update(String.format(INSERT_SCHEDULE, sg.getId(), schedule.getDay(), schedule.getTime(),
					Util.toStringArray(schedule.getLang())));
		}
		return id;
	}

	public Long updateSG(SatsangGhar sg, List<Schedule> scheduleList) throws Exception {

		dbUtility.update(String.format(UPDATE_SATSANG_GHAR, sg.getName(), sg.getCenterType(), sg.getParentCenterid(),
				sg.getAddress1(), sg.getAddress2(), sg.getCity(), sg.getState(), sg.getPinCode(), sg.getMap(),
				sg.getLandline1(), sg.getLandline2(), sg.getMobile1(), sg.getMobile2(), sg.getSecName(),
				sg.getSecMobile(), sg.getId()));
		dbUtility.update(String.format(DEL_SCHEDULE, sg.getId()));
		for (Schedule schedule : scheduleList) {
			dbUtility.update(String.format(INSERT_SCHEDULE, sg.getId(), schedule.getDay(), schedule.getTime(),
					Util.toStringArray(schedule.getLang())));
		}
		return sg.getId();
	}

	public void delSatsangGhar(Long id) {
		dbUtility.update(String.format(DEL_SATSANG_GHAR, id));
		dbUtility.update(String.format(DEL_SCHEDULE, id));
	}

	public List<SatsangGhar> searchSatsangGhar(String whereClause) {

		if (Strings.isNullOrEmpty(whereClause))
			return null;
		List<SatsangGhar> sgList = new ArrayList<>();

		List<List<String>> records = dbUtility.getRecords(String.format(GET_SATSANG_GHAR, whereClause));
		for (int i = 0; i < records.size(); i++) {

			int indx = 0;
			List<String> record = records.get(i);
			SatsangGhar satsangGhar = SatsangGhar.builder().id(getLong(record.get(indx++))).name(record.get(indx++))
					.centerType(record.get(indx++)).parentCenterid(getLong(record.get(indx++)))
					.address1(record.get(indx++)).address2(record.get(indx++)).city(record.get(indx++))
					.state(record.get(indx++)).pinCode(record.get(indx++)).map(record.get(indx++))
					.landline1(record.get(indx++)).landline2(record.get(indx++)).mobile1(getLong(record.get(indx++)))
					.mobile2(getLong(record.get(indx++))).secName(record.get(indx++))
					.secMobile(getLong(record.get(indx++))).numberOfPathis(Integer.parseInt(record.get(indx++)))
					.isStagePathiAlsoGround("t".equalsIgnoreCase(record.get(indx++))).build();

			sgList.add(satsangGhar);
		}
		return sgList;
	}

	public List<Preacher> searchPreacher(String whereClause) {

		if (Strings.isNullOrEmpty(whereClause))
			return null;
		List<Preacher> preachersList = new ArrayList<>();

		List<List<String>> records = dbUtility.getRecords(String.format(GET_ALL_PREACHER, whereClause));
		for (int i = 0; i < records.size(); i++) {

			int ind = 0;
			List<String> record = records.get(i);
			Preacher preacher = Preacher.builder().shortName(record.get(ind++)).name(record.get(ind++))
					.iniDate(record.get(ind++)).sex(record.get(ind++)).sgId(getLong(record.get(ind++)))
					.type(record.get(ind++)).mobile1(getLong(record.get(ind++))).mobile2(getLong(record.get(ind++)))
					.address(record.get(ind++)).city(record.get(ind++))
					.availableDays(Util.getLangArray(record.get(ind++))).lang(Util.getLangArray(record.get(ind++)))
					.tp(record.get(ind++)).build();

			preachersList.add(preacher);
		}
		return preachersList;
	}

	/*
	 * public static final String INSERT_PR1 =
	 * "INSERT INTO preacher( short_name, name,  dob, " +
	 * "initiation_date, sex, sat_ghar_id," +
	 * "            ptype, mobile1, mobile2,address,city,lang,avail_days, transport_profile)"
	 * +
	 * " VALUES ('%s','%s','%s','%s','%s',%d,'%s', %d, %d , '%s','%s','%s','%s','%s')"
	 * ;
	 */

	public void persistPreacher(Preacher preacher) {
		dbUtility.update(handleNull(String.format(INSERT_PR1, preacher.getShortName().trim().toUpperCase(),
				preacher.getName(), preacher.getDob(), preacher.getIniDate(), preacher.getSex(), preacher.getSgId(),
				preacher.getType(), preacher.getMobile1(), preacher.getMobile2(), preacher.getAddress(),
				preacher.getCity(), Util.toStringArray(preacher.getLang()),
				Util.toStringArray(preacher.getAvailableDays()), preacher.getTp())));
	}

	public void updatePreacher(Preacher preacher, String oldShortName) {
		/*
		 * short_name, name, city, dob, initiation_date, sex, sat_ghar_id,
		 * ptype, mobile1, mobile2, lang, transport_profile
		 */
		dbUtility.update(handleNull(String.format(UPDATE_PR, preacher.getShortName().trim().toUpperCase(),
				preacher.getName(), preacher.getCity(), preacher.getDob(), preacher.getIniDate(), preacher.getSex(),
				preacher.getSgId(), preacher.getType(), preacher.getMobile1(), preacher.getMobile2(),
				Util.toStringArray(preacher.getLang()), preacher.getTp(), preacher.getAddress(),
				Util.toStringArray(preacher.getAvailableDays()), oldShortName)));
	}

	public static void main(String[] args) {
		DatabaseHelper databaseHelper = new DatabaseHelper();

		Attendance attendance = Attendance.builder().sgId(3l).date("11-Mar-2010").gents(123l).build();
		databaseHelper.addAttendance(attendance);

	}

	public static final String UPDATE_ATTENDANCE = "UPDATE satsang_attendance "
			+ " SET  pathi='%s', preacher='%s', book='%s',saint='%s', gents=%s, ladies=%s, children=%s,"
			+ " four_wheeler=%s, two_wheeler=%s " + " WHERE sgid=%s and date='%s'";

	public List<Preacher> getPreacher(String whereClause) {
		if (Strings.isNullOrEmpty(whereClause))
			return null;
		List<Preacher> preacherList = new ArrayList<>();

		List<List<String>> records = dbUtility.getRecords(String.format(GET_PR, whereClause));
		for (int i = 0; i < records.size(); i++) {
			List<String> record = records.get(i);
			int ind = 0;
			/*
			 * SELECT short_name, name, to_char(initiation_Date,'dd-Mon-YYYY'),
			 * sex, sat_ghar_id, ptype, mobile1, mobile2, address, city,
			 * avail_days, lang, transport_profile from preacher where %s order
			 * by name
			 */

			Preacher preacher = Preacher.builder().shortName(record.get(ind++)).name(record.get(ind++))
					.iniDate(record.get(ind++)).sex(record.get(ind++)).sgId(getLong(record.get(ind++)))
					.type(record.get(ind++)).mobile1(getLong(record.get(ind++))).mobile2(getLong(record.get(ind++)))
					.address(record.get(ind++)).city(record.get(ind++))
					.availableDays(Util.getLangArray(record.get(ind++))).lang(Util.getLangArray(record.get(ind++)))
					.tp(record.get(ind++)).build();
			preacherList.add(preacher);
		}

		return preacherList;
	}

	public Map<String, List<PreacherAllocation>> getAllocatedPreacherMap(Long sgId, String startDate, String endDate) {

		Map<String, List<PreacherAllocation>> map = new ConcurrentHashMap<>();

		List<List<String>> res = dbUtility
				.getRecords(String.format(GET_ALLOCATED_PREACHER, sgId, startDate, endDate, sgId, startDate, endDate));

		for (List<String> rec : res) {

			String date = rec.get(0);
			String time = rec.get(1);
			String sn = rec.get(2);

			List<PreacherAllocation> list = map.get(date);
			if (list == null) {
				list = new ArrayList<>();
				map.put(date, list);
			}
			list.add(PreacherAllocation.builder().date(date).time(time).shortName(sn).build());
		}
		res = dbUtility
				.getRecords(String.format(GET_ALLOCATED_PATHIS, sgId, startDate, endDate, sgId, startDate, endDate));

		for (List<String> rec : res) {

			String date = rec.get(0);
			String time = rec.get(1);
			String[] snArray = Util.getLangArray(rec.get(2));
			System.out.println(snArray);
			List<PreacherAllocation> list = map.get(date);
			if (list == null) {
				list = new ArrayList<>();
				map.put(date, list);
			}
			for (String sn : snArray) {
				list.add(PreacherAllocation.builder().date(date).time(time).shortName(sn).build());
			}
		}

		return map;
	}

	public List<Allocation> getAllocation(Long satsangGharId, String startDate, String endDate) {
		List<Allocation> list = new ArrayList<>();
		if (null == satsangGharId)
			return list;

		List<List<String>> records = dbUtility
				.getRecords(String.format(GET_ALLOCATION, satsangGharId, startDate, endDate));
		for (List<String> record : records) {
			int ind = 1;
			Allocation allocation = Allocation.builder().sgId(satsangGharId).satDate(record.get(ind++))
					.time(record.get(ind++)).pathi(Util.getLangArray(record.get(ind++))).preacher(record.get(ind++))
					.isCD("t".equalsIgnoreCase(record.get(ind++))).cdId(record.get(ind++))
					.createdDate(record.get(ind++)).build();
			list.add(allocation);
		}
		return list;
	}

	public List<Allocation> getAllocation(String shortName, String startDate, String endDate) {
		List<Allocation> list = new ArrayList<>();
		if (null == shortName)
			return list;

		List<List<String>> records = dbUtility.getRecords(
				String.format(GET_ALLOCATION_BY_PREAHER, shortName, startDate, endDate, shortName, startDate, endDate));

		for (List<String> record : records) {
			int ind = 0;
			Allocation allocation = Allocation.builder().sgId(Long.parseLong(record.get(ind++)))
					.satsangGharName(record.get(ind++)).satDate(record.get(ind++)).day(record.get(ind++))
					.time(record.get(ind++)).pathi(Util.getLangArray(record.get(ind++))).preacher(record.get(ind++))
					.isStagePathiAlsoGround("t".equalsIgnoreCase(record.get(ind++))).build();
			list.add(allocation);
		}
		return list;
	}

	public List<String> getDayList(Long id) {
		List<List<String>> records = dbUtility.getRecords(String.format(GET_SAT_DAY, id));
		List<String> list = new ArrayList<>();
		for (List<String> record : records) {
			list.add(record.get(0));
		}

		return list;
	}

	public void addAllocation(Allocation allocation, boolean isCdUpdate) {
		int i = updateAllocation(allocation, isCdUpdate);
		if (i == 0)
			dbUtility.update(String.format(INSERT_ALLOCATION, allocation.getSgId(), allocation.getSatDate(),
					allocation.getTime(), Util.toStringArray(allocation.getPathi()), allocation.getPreacher(),
					allocation.getIsCD(), allocation.getCdId()));
	}

	public int updateAllocation(Allocation allocation, boolean isCdUpdate) {

		if (isCdUpdate)
			return dbUtility.update(String.format(UPDATE_CD_ALLOCATION, allocation.getCdId(), allocation.getSgId(),
					allocation.getSatDate()));
		else
			return dbUtility.update(String.format(UPDATE_CONT_ALLOCATION, Util.toStringArray(allocation.getPathi()),
					allocation.getPreacher(), allocation.getIsCD(), allocation.getSgId(), allocation.getSatDate()));
	}

	public void addAttendance(Attendance attendance) {
		int i = updateAttendance(attendance);
		if (i == 0)
			dbUtility.update(String.format(INSERT_ATTENDANCE, attendance.getSgId(), attendance.getDate(),
					attendance.getPathi(), attendance.getPreacher(), attendance.getBook(), attendance.getSaint(),
					attendance.getGents(), attendance.getLadies(), attendance.getChildren(),
					attendance.getFour_wheeler(), attendance.getTwo_wheeler(),attendance.getShabad()));
	}

	/*
	 * public static final String INSERT_ATTENDANCE=
	 * "INSERT INTO satsang_attendance("+
	 * "sgid, date, pathi, preacher, book, saint, gents, ladies, children, four_wheeler, two_wheeler)"
	 * + "VALUES (%s, '%s', '%s', '%s', '%s', '%s', %s, %s, %s, %s, %s);";
	 */
	public int updateAttendance(Attendance attendance) {

		return dbUtility.update(String.format(UPDATE_ATTENDANCE, attendance.getPathi(), attendance.getPreacher(),
				attendance.getBook(), attendance.getSaint(), attendance.getGents(), attendance.getLadies(),
				attendance.getChildren(), attendance.getFour_wheeler(), attendance.getTwo_wheeler(),
				attendance.getSgId(), attendance.getDate(),attendance.getShabad()));
	}

	/*
	 * public static final String UPDATE_ATTENDANCE="UPDATE satsang_attendance"+
	 * "SET sgid='%s', date='%s', pathi='%s', preacher='%s', book='%s', saint='%s', gents='%s', ladies='%s', children='%s', four_wheeler='%s', two_wheeler='%s',"
	 * + "WHERE <condition>;";
	 */

	/*
	 * 
	 * "SELECT sgid, date, pathi, preacher," +
	 * " book, saint, gents, ladies, children, " +
	 * "four_wheeler, two_wheeler from satsang_attendance "+
	 * "WHERE sgid=%s and date='%s';";
	 * 
	 * 
	 * 
	 */
	public Attendance getAttedance(Long sgid, String date) {

		new ConcurrentHashMap<>();
		List<String> record = dbUtility.getRecord(String.format(GET_ATTENDANCE, sgid));
		if (null == record)
			return null;
		if (0 == record.size())
			return null;
		int ind = 0;
		Long sgId=Long.parseLong(record.get(ind++));
		String date1=record.get(ind++);
		String pathi=record.get(ind++);
		String preacher=record.get(ind++);
		String book=record.get(ind++);
		String saint=record.get(ind++);
		Long gents=Long.parseLong(record.get(ind++));
		Long ladies=Long.parseLong(record.get(ind++));
		Long children=Long.parseLong(record.get(ind++));
		Long fw=Long.parseLong(record.get(ind++));
		Long tw=Long.parseLong(record.get(ind++));
		String shabad=record.get(ind++);

		
		Attendance attendance = Attendance.builder().sgId(sgId).date(date1).pathi(pathi).
				preacher(preacher).book(book).saint(saint).gents(gents).ladies(ladies).children(children).four_wheeler(fw).two_wheeler(tw).shabad(shabad)
				.build();

		return attendance;
	}

	private Long getLong(String parameter) {

		if (Strings.isNullOrEmpty(parameter) || "null".equalsIgnoreCase(parameter))
			return null;
		else
			return Long.parseLong(parameter);
	}

	public Long getSgId(String sgName) {
		return getLong(dbUtility.get(String.format(GET_SG_ID, sgName)));
	}

	public User verifyUser(String userName, String password) throws Exception {
		List<String> res = dbUtility.getRecord(String.format(GET_USER, userName, password));
		if (null == res)
			return null;
		if (res.size() == 0)
			return null;

		return User.builder().name(res.get(0)).userName(res.get(1)).emailId(res.get(2)).build();
	}

	public Map<String, Schedule> getSchedules(Long sgid) {

		Map<String, Schedule> map = new ConcurrentHashMap<>();
		List<List<String>> records = dbUtility.getRecords(String.format(GET_SCHEDULE, sgid));
		for (List<String> record : records) {
			int ind = 0;
			Schedule schedule = Schedule.builder().id(sgid).day(record.get(ind++)).time(record.get(ind++))
					.lang(Util.getLangArray(record.get(ind++))).build();
			map.put(schedule.getDay(), schedule);
		}
		return map;
	}

	public List<Language> getLang() {
		List<Language> list = new ArrayList<>();
		List<List<String>> records = dbUtility.getRecords(String.format(GET_LANG));
		for (List<String> record : records) {
			Language lang = Language.builder().lang(record.get(0)).local(record.get(1)).build();
			list.add(lang);
		}
		return list;
	}

	public void addLeaves(Leave leave) {
		if (leave.getId() == null) {
			leave.setId(Long.parseLong(dbUtility.get(GET_LV_SEQ_ID)));
			dbUtility.update(String.format(INSERT_LEAVE, leave.getId(), leave.getShortName(), leave.getStartDate(),
					leave.getEndDate()));
		} else {
			updateLeave(leave);
		}
	}

	public void updateLeave(Leave leave) {
		if (Strings.isNullOrEmpty(leave.getStartDate()))
			dbUtility.update(String.format(DEL_LEAVE, leave.getId()));
		else

			dbUtility.update(String.format(UPDATE_LEAVE, leave.getShortName(), leave.getStartDate(), leave.getEndDate(),
					leave.getId()));
	}

	public List<Leave> getLeaves(String shortName, String startDate, String endDate) {

		List<Leave> list = new ArrayList<>();
		List<List<String>> records = dbUtility.getRecords(String.format(GET_LEAVES, shortName, startDate, endDate));
		for (List<String> record : records) {
			int ind = 0;
			Leave leave = Leave.builder().id(Long.parseLong(record.get(ind++))).shortName(record.get(ind++))
					.startDate(record.get(ind++)).endDate(record.get(ind++)).build();
			list.add(leave);
		}
		return list;
	}

	public Map<String, List<Leave>> getLeaveMap(String startDate, String endDate) {

		List<List<String>> records = dbUtility.getRecords(String.format(GET_LEAVES_BY_DATE, startDate, endDate));
		Map<String, List<Leave>> map = new ConcurrentHashMap<>();

		for (List<String> record : records) {
			String shortName = record.get(0);
			Leave leave = Leave.builder().shortName(shortName).startDate(record.get(1)).endDate(record.get(2)).build();

			List<Leave> leaveList = map.get(shortName);
			if (leaveList == null) {
				leaveList = new ArrayList<>();
				map.put(shortName, leaveList);
			}

			leaveList.add(leave);
		}
		return map;
	}

	public String handleNull(String query) {
		String resp = "'null'";
		return query.replace(resp, "null");
	}

	public List<State> getStateList() {
		List<State> list = new ArrayList<>();
		List<List<String>> records = dbUtility.getRecords(String.format(GET_STATES));
		for (List<String> record : records) {
			int ind = 0;
			State state = State.builder().code(record.get(ind++)).name(record.get(ind++)).build();
			list.add(state);
		}
		return list;
	}

	public List<City> getCityList() {
		return getCityList("true");
	}

	public List<City> getCityList(String whereClause) {
		List<City> list = new ArrayList<>();
		List<List<String>> records = dbUtility.getRecords(String.format(GET_CITIES, whereClause));
		for (List<String> record : records) {
			int ind = 0;
			City state = City.builder().code(record.get(ind++)).name(record.get(ind++)).stateCode(record.get(ind++))
					.build();
			list.add(state);
		}
		return list;
	}

	public void addCity(City city) {

		String whereClause = "code='" + city.getCode() + "'";
		List<City> list = getCityList(whereClause);

		if (list.size() > 0) {
			dbUtility.update(String.format(DEL_CITY, whereClause));
		}

		whereClause = "name='" + city.getName() + "'";
		list = getCityList(whereClause);

		if (list.size() > 0) {
			dbUtility.update(String.format(DEL_CITY, whereClause));
		}

		dbUtility.update(String.format(INSERT_CITY, city.getCode(), city.getName(), city.getStateCode()));
	}

	public void addCD(CD cd) {
		CD getCd = getCD(cd.getId());

		if (getCd != null) {
			dbUtility.update(String.format(UPDATE_CD, cd.getDesc1(), cd.getDesc2(), cd.getId()));
			return;
		}

		dbUtility.update(String.format(INSERT_CD, cd.getId(), cd.getDesc1(), cd.getDesc2()));
	}

	public CD getCD(String id) {
		List<String> record = dbUtility.getRecord(String.format(GET_CD, id));
		if (null == record)
			return null;
		int k = 0;
		CD cd = CD.builder().id(record.get(k++)).desc1(record.get(k++)).desc2(record.get(k++)).build();
		return cd;
	}

	public List<CD> getAllCd() {
		List<CD> list = new ArrayList<>();
		List<List<String>> records = dbUtility.getRecords(String.format(GET_ALL_CD));
		for (List<String> record : records) {
			int ind = 0;
			CD cd = CD.builder().id(record.get(ind++)).desc1(record.get(ind++)).desc2(record.get(ind++)).build();
			list.add(cd);
		}
		return list;
	}
}
